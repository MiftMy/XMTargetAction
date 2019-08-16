//
//  XMMediator+City.m
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMMediator+City.h"
#import <objc/runtime.h>

/// target。 和module中Target_之后的一样
NSString * const kCTMediatorTargetCity = @"City";

/// actions。 和module中Target_xxxx文件中的方法Action_后的一样
NSString * const kXMMediatorActionCityListVC = @"cityListViewController";//
NSString * const kXMMediatorActionTestVC = @"testViewController";


@implementation XMMediator(City)
#pragma mark - public
- (UIViewController *)Mediator_cityListVC {
    UIViewController *viewController = [self performTarget:kCTMediatorTargetCity
                                                    action:kXMMediatorActionCityListVC
                                                    params:nil
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

- (UIViewController *)Mediator_testVC {
    UIViewController *viewController = [self performTarget:kCTMediatorTargetCity
                                                    action:kXMMediatorActionTestVC
                                                    params:nil
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}
@end
