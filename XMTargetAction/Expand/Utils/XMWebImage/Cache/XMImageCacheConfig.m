//
//  XMImageCacheConfig.m
//  XMDemo
//
//  Created by mifit on 2018/5/24.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMImageCacheConfig.h"

static const NSInteger kDefaultCacheMaxCacheAge = 604800; // 1 天86400， 一周时间 604800

@implementation XMImageCacheConfig

- (instancetype)init {
    if (self = [super init]) {
        _shouldDecompressImages = YES;
        _shouldCacheImagesInMemory = YES;
        _maxCacheAge = kDefaultCacheMaxCacheAge;
        _maxCacheSize = 0;
    }
    return self;
}
@end
