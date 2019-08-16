//
//  XMHomeData.m
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMHomeData.h"
#import "XMHomePageItemModel.h"

@implementation XMHomeData
/// 视频model
+ (NSArray<XMHomePageItemModel *> *)videoModels {
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger indx = 0; indx < 3; indx++) {
        XMHomePageItemModel *model = [XMHomePageItemModel new];
        model.cellType = XMCellTypeVideo;
        model.imgName = @"favicon_sel";
        model.indicatorType = UITableViewCellAccessoryDisclosureIndicator;
        NSString *title = nil;
        if (indx == 0) {
            title = @"top250";
        }
        if (indx == 1) {
            title = @"正在热映";
        }
        if (indx == 2) {
            title = @"即将上映";
        }
        model.title = title;
        model.titleColor = @"";
        [list addObject:model];
    }
    return list;
}

/// 其他数据model
+ (NSArray<XMHomePageItemModel *> *)otherModels {
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger indx = 0; indx < 4; indx++) {
        XMHomePageItemModel *model = [XMHomePageItemModel new];
        model.cellType = XMCellTypeOther;
        model.indicatorType = UITableViewCellAccessoryDetailButton;
        NSString *title = nil;
        if (indx == 0) {
            title = @"苍老师主页";
        }
        if (indx == 1) {
            title = @"苍老师相册";
        }
        if (indx == 2) {
            title = @"测试VC";
        }
        if (indx == 3) {
            title = @"城市列表";
        }
        model.title = title;
        if (indx % 2 == 0) {
            model.showMode = XMVCShowModePresent;
            model.showModeStr = @"Present vc";
        } else {
            model.showMode = XMVCShowModePush;
            model.showModeStr = @"Push vc";
        }
        
        [list addObject:model];
    }
    return list;
}
@end
