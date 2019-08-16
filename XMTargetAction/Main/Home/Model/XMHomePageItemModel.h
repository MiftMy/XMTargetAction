//
//  XMHomePageItemModel.h
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XMVCShowMode)  {
    XMVCShowModePresent = 0,
    XMVCShowModePush
};

typedef NS_ENUM(NSInteger, XMCellType)  {
    XMCellTypeVideo = 0,
    XMCellTypeOther
};

/*
 * 首页model，二合一，减少耦合
 */
@interface XMHomePageItemModel : NSObject
@property (nonatomic, assign) XMCellType cellType;
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, assign) UITableViewCellAccessoryType indicatorType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titleColor;
@property (nonatomic, assign) XMVCShowMode showMode;
@property (nonatomic, copy) NSString *showModeStr;
@end
