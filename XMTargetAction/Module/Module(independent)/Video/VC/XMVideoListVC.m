//
//  XMVideoListVC.m
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMVideoListVC.h"
#import "UIImageView+WebCache.h"
#import "XMHttpRequest.h"

#import "XMVideoHotCellStyle1.h"
#import "XMVideoHotCellStyle2.h"

@interface XMVideoListVC ()
{
    UIButton *tbFootView;
}
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger addStep;
@property (nonatomic, strong) NSMutableArray *cellCacheHeight;
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation XMVideoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addStep = 15;
    self.total = -1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refleshData:)];
    self.navigationItem.rightBarButtonItem = rItem;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitleColor:XMNGreenColor forState:UIControlStateNormal];
    [btn setTitle:@"点击加载15条数据(0已加载)" forState:UIControlStateNormal];
    tbFootView = btn;
    
    [btn addTarget:self action:@selector(loadMoreVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoHotCellStyle1" bundle:nil] forCellReuseIdentifier:@"XMVideoHotCellStyle1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoHotCellStyle2" bundle:nil] forCellReuseIdentifier:@"XMVideoHotCellStyle2"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self refleshData:self.navigationItem.rightBarButtonItem];
}
#pragma mark - private
- (void)updateTbFootState {
    NSString *str = [NSString stringWithFormat:@"点击加载15条(%ld已加载)", self.dataList.count];
    [tbFootView setTitle:str forState:UIControlStateNormal];
}

- (void)refleshData:(id)sender {
    UIBarButtonItem *bItem = (UIBarButtonItem *)sender;
    bItem.enabled = NO;
    [self.dataList removeAllObjects];
    [self.cellCacheHeight removeAllObjects];
    [self requestVideoesAt:0 count:self.addStep completion:^(BOOL isOK, NSString *error) {
        if (isOK) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self updateTbFootState];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            bItem.enabled = YES;
        });
    }];
}

- (void)loadMoreVideo:(id)sender {
    [tbFootView setTitle:@"正在加载..." forState:UIControlStateNormal];
    [self requestVideoesAt:self.dataList.count count:self.addStep completion:^(BOOL isOK, NSString *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self updateTbFootState];
        });
    }];
}

- (void)addCellHeightForList:(NSArray *)list {
    for (NSDictionary *item in list) {
        NSDictionary *rating = item[@"rating"];
        CGFloat r = [rating[@"average"]doubleValue];
        r = r*10;
        NSInteger rTem = ceilf(r);
        CGFloat h = 78;
        if (rTem%2 != 0) {
            h = 157;
        }
        [self.cellCacheHeight addObject:@(h)];
    }
}

- (void)requestVideoesAt:(NSInteger)begin count:(NSInteger)count completion:(void(^)(BOOL isOK, NSString *error))completionBlock {
    NSString *urlStr = [self.movieListUrl stringByAppendingFormat:@"?start=%ld&count=%ld", begin, count];
    [XMHttpRequest GET:urlStr completed:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSError *err;
            // nsdata 转 dic
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
            if (err) {
                if (completionBlock) {
                    completionBlock(NO, [err description]);
                }
                return;
            }
            self.total = [dic[@"total"]integerValue];
            NSArray *listTem = dic[@"subjects"];
            if (listTem && listTem.count > 0) {
                // 添加新数据
                [self.dataList addObjectsFromArray:listTem];
                // 计算cell 高，避免计算
                [self addCellHeightForList:listTem];
            }
            if (completionBlock) {
                completionBlock(YES, nil);
            }
        } else {
            if (completionBlock) {
                completionBlock(NO, [error description]);
            }
        }
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger height =  [self.cellCacheHeight[indexPath.row]integerValue];
    NSDictionary *item = self.dataList[indexPath.row];
    
    // 样式1
    if (height > 100) {
        XMVideoHotCellStyle1 *cell = [tableView dequeueReusableCellWithIdentifier:@"XMVideoHotCellStyle1"];
        [cell updateCellWithParam:item];
        return cell;
    }
    
    // 样式2
    XMVideoHotCellStyle2 *cell = [tableView dequeueReusableCellWithIdentifier:@"XMVideoHotCellStyle2"];
    [cell updateCellWithParam:item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellCacheHeight[indexPath.row]floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return tbFootView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

#pragma mark - lazy load
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (NSMutableArray *)cellCacheHeight {
    if (!_cellCacheHeight) {
        _cellCacheHeight = [NSMutableArray array];
    }
    return _cellCacheHeight;
}
@end

