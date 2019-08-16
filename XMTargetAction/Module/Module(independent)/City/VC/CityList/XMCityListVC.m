//
//  XMCityListVC.m
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMCityListVC.h"
#import "XMHttpURL.h"
#import "XMHttpRequest.h"
#import "XMBaseVC_Tools.h"
#import "XMBaseMacro.h"

@interface XMCityListVC ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (weak, nonatomic) IBOutlet UIButton *loadMoreBtn;

@property (nonatomic, assign) NSInteger addStep;
@property (nonatomic, strong) NSMutableArray *cityList;
@end

@implementation XMCityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"城市列表";
    self.addStep = 17;
    self.tbView.dataSource = self;
    self.tbView.delegate = self;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refleshCity:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [self refleshCity:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy load
- (NSMutableArray *)cityList {
    if (!_cityList) {
        _cityList = [NSMutableArray array];
    }
    return _cityList;
}

#pragma mark - private
/// 刷新视频
- (void)refleshCity:(id)sender {
    [self.cityList removeAllObjects];
    [self.loadMoreBtn setTitle:@"正在加载" forState:UIControlStateNormal];
    [self loadMoreCityAt:0 count:self.addStep completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView reloadData];
            [self updateLoadState:self.cityList.count];
        });
    }];
}

/// 加载更多视频。  begin起始位置 count视频个数
- (void)loadMoreCityAt:(NSInteger)begin count:(NSInteger)count completion:(void(^)(void))completionBlock {
    NSString *urlStr = [XMHttpURL cityListURL];
    urlStr = [urlStr stringByAppendingFormat:@"?start=%ld&count=%ld", begin, count];
    [XMHttpRequest GET:urlStr completed:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSArray *cities = jsonDict[@"locs"];
            if (cities) {
                [self.cityList addObjectsFromArray:cities];
            } else {
                [self toastMsg:@"没有更多数据"];
            }
        } else {
            [self toastMsg:[error description]];
        }
        if (completionBlock) {
            completionBlock();
        }
    }];
}

- (IBAction)addMoreCities:(id)sender {
    UIButton *btn = (UIButton *)sender;
    [btn setTitle:@"正在加载" forState:UIControlStateNormal];
    [self loadMoreCityAt:self.cityList.count count:self.addStep completion:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tbView reloadData];
            [self updateLoadState:self.cityList.count];
        });
    }];
}

- (void)updateLoadState:(NSInteger)count {
    NSString *str = [NSString stringWithFormat:@"点击加载%ld个城市(%ld已加载)", self.addStep, self.cityList.count];
    [self.loadMoreBtn setTitle:str forState:UIControlStateNormal];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cityCell";
    NSDictionary *modelDict = self.cityList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        [cell.textLabel setTextColor:XMNGreenColor];
    }
    cell.textLabel.text = modelDict[@"name"];
    cell.detailTextLabel.text = modelDict[@"uid"];
    return cell;
}

@end
