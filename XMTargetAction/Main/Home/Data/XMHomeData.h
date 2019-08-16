//
//  XMHomeData.h
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XMHomePageItemModel;


@interface XMHomeData : NSObject
/// 视频model，类型XMHomePageItemModel
+ (NSArray<XMHomePageItemModel *> *)videoModels;

/// 其他数据model， 类型XMHomePageItemModel
+ (NSArray<XMHomePageItemModel *> *)otherModels;
@end
