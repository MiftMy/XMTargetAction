//
//  XMImageCache.h
//  XMDemo
//
//  Created by mifit on 2018/5/24.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XMImageCacheConfig.h"

// 缓存类型
typedef NS_ENUM(NSInteger, XMImageCacheType) {
    XMImageCacheTypeNone  = 1 << 0,
    XMImageCacheTypeDisk  = 1 << 1,
    XMImageCacheTypeMemory = 1 << 2
};

/*
    图片缓存类
    缓存分磁盘缓存和内存缓存
 */
@interface XMImageCache : NSObject
@property (nonatomic, nonnull, readonly) XMImageCacheConfig *config;
@property (assign, nonatomic) NSUInteger maxMemoryCost;
/// 单例
+ (nonnull instancetype)sharedImageCache;

/// 以某个命名空间创建缓存路径
- (nonnull instancetype)initWithNamespace:(nonnull NSString *)ns;

/// 磁盘缓存路径
- (nullable NSString *)diskCachePath:(nonnull NSString*)fullNamespace;

/*
 *  保存图片
 * @param image             需要保存地图片
 * @param key               图片缓存key，通常跟url有关
 * @param toDisk            是否保存到磁盘
 * @param completionBlock   完成后回调
 */
- (void)storeImage:(nullable UIImage *)image
            forKey:(nullable NSString *)key
            toDisk:(BOOL)toDisk
        completion:(nullable void (^)(void))completionBlock;

/*
 *  检测图片是否在缓存中
 * @param key               图片缓存key，通常跟url有关
 * @param completionBlock   完成后回调是否在缓存中
 */
- (void)diskImageExistsWithKey:(nullable NSString *)key
                    completion:(nullable void (^)(BOOL isInCache))completionBlock;

/// 从磁盘中获取相对应key的图片
- (nullable UIImage *)imageFromMemoryCacheForKey:(nullable NSString *)key;
/// 从内存中获取相对应key的图片
- (nullable UIImage *)imageFromDiskCacheForKey:(nullable NSString *)key;
/// 先从内存获取图片，没有再从磁盘获取
- (nullable UIImage *)imageFromCacheForKey:(nullable NSString *)key;

/// 清理磁盘缓存
- (void)clearDiskOnCompletion:(nullable void (^)(void))completion;

- (nullable NSOperation *)queryCacheOperationForKey:(nullable NSString *)key done:(nullable void(^)(UIImage * _Nullable image, NSData * _Nullable data, XMImageCacheType cacheType))doneBlock;

/// 清理内存缓存
- (void)clearMemory;

/// 删除超过期限的图片
- (void)deleteOldFilesWithCompletionBlock:(nullable void (^)(void))completionBlock;

/// 获取指定key的缓存文件路径，即图片路径
- (nullable NSString *)defaultCachePathForKey:(nullable NSString *)key;
@end
