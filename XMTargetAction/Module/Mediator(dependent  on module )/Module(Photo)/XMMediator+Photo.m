//
//  XMMediator+Photo.m
//  XMDemo
//
//  Created by mifit on 2018/5/29.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMMediator+Photo.h"

/// target。 和module中Target_之后的一样
NSString * const kCTMediatorTargetPhoto = @"Photo";

/// actions。 和module中Target_xxxx文件中的方法Action_后的一样
NSString * const kXMMediatorActionTeacherPhotoVC = @"teacherPhotoViewController";//
NSString * const kXMMediatorActionTeacherHomeVC = @"teacherHomeViewController";

@implementation XMMediator(Photo)
- (UIViewController *)Mediator_teacherHomeVC:(NSString *)imgUrl {
    UIViewController *viewController = [self performTarget:kCTMediatorTargetPhoto
                                                    action:kXMMediatorActionTeacherHomeVC
                                                    params:@{@"imgUrl":imgUrl}
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

- (UIViewController *)Mediator_teacherPhotoVC:(NSArray *)photoList {
    UIViewController *viewController = [self performTarget:kCTMediatorTargetPhoto
                                                    action:kXMMediatorActionTeacherPhotoVC
                                                    params:@{@"images":photoList}
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
