//
//  XMHomeVC.m
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMHomeVC.h"

// mvc
#import "XMHomeData.h"
#import "XMHomePageItemModel.h"
#import "XMOtherItemCell.h"

// url管理类
#import "XMHttpURL.h"


// vc
#import "XMVideoListVC.h"
#import "XMTeacherHomeVC.h"
#import "XMTeacherPhotoVC.h"

// 组件
#import "XMMediator+City.h"
#import "XMMediator+Photo.h"
#import "XMMediator+Video.h"

@interface XMHomeVC ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) NSArray *videoItemsList;
@property (nonatomic, strong) NSArray *otherItemsList;
@end

@implementation XMHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"主页";

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.videoItemsList = [XMHomeData videoModels];
    self.otherItemsList = [XMHomeData otherModels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.videoItemsList.count;
    }
    return self.otherItemsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMHomePageItemModel *model = nil;
    NSString *identifer = nil;
    if (indexPath.section == 0) {
        model = self.videoItemsList[indexPath.row];
        identifer = @"XMVideoItemCell";
    }
    if (indexPath.section == 1) {
        model = self.otherItemsList[indexPath.row];
        identifer = @"XMOtherItemCell";
    }
    UITableViewCell *cell = [self cellFromTable:tableView model:model reuseIdentifier:identifer];
    [cell updateCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 40;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self dealwithVideoItemAt:indexPath.row];
    }
    if (indexPath.section == 1) {
        [self dealwithOtherItemAt:indexPath.row];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"豆瓣电影";
    }
    return @"其他";
}


#pragma mark - private
- (UITableViewCell *)cellFromTable:(UITableView *)tb model:(XMHomePageItemModel *)model reuseIdentifier:(NSString  *)identifer {
    UITableViewCell *cell = [tb dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        UITableViewCellStyle style = UITableViewCellStyleSubtitle;
        if (model.cellType == XMCellTypeVideo) {
            style = UITableViewCellStyleValue1;
        }
        cell = [[UITableViewCell alloc]initWithStyle:style reuseIdentifier:identifer];
    }
    return cell;
}

// 使用传统模式
- (void)dealwithVideoItemAt:(NSInteger)indx {
    if (indx == 0) {
        XMVideoListVC *vc = [XMVideoListVC new];
        vc.movieListUrl = [XMHttpURL top250MoviesURL];
        vc.title = @"top250";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indx == 1) {
        XMVideoListVC *vc = [XMVideoListVC new];
        vc.movieListUrl = [XMHttpURL HitMoviesURL];
        vc.title = @"正在热播";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indx == 2) {
        XMVideoListVC *vc = [XMVideoListVC new];
        vc.movieListUrl = [XMHttpURL upcomingMoviesURL];
        vc.title = @"即将上映";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 使用Target action 组件模式
- (void)dealwithOtherItemAt:(NSInteger)indx {
    if (indx == 0) {
        UIViewController *vc = [[XMMediator sharedInstance]Mediator_teacherHomeVC:[XMHttpURL teacherHomePageURL]];
        [self presentViewController:vc animated:YES completion:nil];
    }
    if (indx == 1) {
        NSArray *imgList = @[[XMHttpURL teacherPhotoAlbumPic1URL], [XMHttpURL teacherPhotoAlbumPic2URL], [XMHttpURL teacherPhotoAlbumPic3URL]];
        UIViewController *vc = [[XMMediator sharedInstance]Mediator_teacherPhotoVC:imgList];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indx == 2) {
        UIViewController *vc = [[XMMediator sharedInstance]Mediator_testVC];
        [self presentViewController:vc animated:YES completion:nil];
    }
    if (indx == 3) {
        UIViewController *vc = [[XMMediator sharedInstance]Mediator_cityListVC];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
