//
//  Target_City.h
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target_City : NSObject
/*
 *  城市列表vc
 */
- (UIViewController *)Action_cityListViewController:(NSDictionary *)param;

/*
 *  测试vc
 */
- (UIViewController *)Action_testViewController:(NSDictionary *)param;
@end
