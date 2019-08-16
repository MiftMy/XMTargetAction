//
//  XMImageCacheConfig.h
//  XMDemo
//
//  Created by mifit on 2018/5/24.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    cache 配置信息
 */
@interface XMImageCacheConfig : NSObject
/// 图像质量减少占用内存,即除去透明度。默认YES
@property (assign, nonatomic) BOOL shouldDecompressImages;
/// 是否缓存图片到内存，默认YES
@property (assign, nonatomic) BOOL shouldCacheImagesInMemory;
/// 缓存最长时间，单位秒， 默认一周
@property (assign, nonatomic) NSInteger maxCacheAge;
/// 缓存最大容量，单位字节, 默认0
@property (assign, nonatomic) NSUInteger maxCacheSize;
@end
