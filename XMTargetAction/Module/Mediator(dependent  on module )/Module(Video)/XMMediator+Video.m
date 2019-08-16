//
//  XMMediator+Video.m
//  XMDemo
//
//  Created by mifit on 2018/5/30.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMMediator+Video.h"

/// target。 和module中Target_之后的一样
NSString * const kCTMediatorTargetVideo = @"Video";

/// actions。 和module中Target_xxxx文件中的方法Action_后的一样
NSString * const kXMMediatorActionVideoListVC = @"movieListViewController";//


@implementation XMMediator(Video)
- (UIViewController *)Mediator_teacherPhotoVC:(NSString *)movieListUrl {
    UIViewController *viewController = [self performTarget:kCTMediatorTargetVideo
                                                    action:kXMMediatorActionVideoListVC
                                                    params:@{@"movieListUrl":movieListUrl}
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
