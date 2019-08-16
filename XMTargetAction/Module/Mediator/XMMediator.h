//
//  XMMediator.h
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 消息传递中介
@interface XMMediator : NSObject
/// 单例
+ (instancetype)sharedInstance;

/// 远程APP调用接口
- (id)performActionWithURL:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;

/// 本地组件调用接口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/// 释放缓存
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;
@end
