//
//  XMImageManager.m
//  XMDemo
//
//  Created by mifit on 2018/5/24.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMImageManager.h"
#import "XMImageCache.h"
#import "XMImageDownloader.h"

#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}

@interface XMWebImageOperation : NSObject

@property (assign, nonatomic, getter = isCancelled) BOOL cancelled;
@property (strong, nonatomic, nullable) XMImageDownloadToken *downloadToken;
@property (copy, nonatomic, nullable) void(^cancelBlock)(void);
@property (strong, nonatomic, nullable) NSOperation *cacheOperation;
@property (weak, nonatomic, nullable) XMImageManager *manager;
@end

@implementation XMWebImageOperation
- (void)cancel {
    @synchronized(self) {
        self.cancelled = YES;
        if (self.cacheOperation) {
            [self.cacheOperation cancel];
            self.cacheOperation = nil;
        }
        if (self.downloadToken) {
            [self.manager.imageDownloader cancel:self.downloadToken];
        }
        [self.manager safelyRemoveOperationFromRunning:self];
    }
}
@end


@interface XMImageManager()
@property (strong, nonatomic, nonnull) NSMutableSet<NSURL *> *failedURLs;
@property (strong, nonatomic, nonnull) NSMutableArray<XMWebImageOperation *> *runningOperations;
@property (strong, nonatomic, nullable) XMImageCache *imageCache;
@property (nonatomic, copy, nullable) NSString * _Nullable (^cacheKeyFilter)(NSURL * _Nullable url);

@end

@implementation XMImageManager
+ (nonnull instancetype)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (nonnull instancetype)init {
    XMImageCache *cache = [XMImageCache sharedImageCache];
    XMImageDownloader *downloader = [XMImageDownloader sharedDownloader];
    return [self initWithCache:cache downloader:downloader];
}

- (nonnull instancetype)initWithCache:(nonnull XMImageCache *)cache downloader:(nonnull XMImageDownloader *)downloader {
    if ((self = [super init])) {
        _imageCache = cache;
        _imageDownloader = downloader;
        _failedURLs = [NSMutableSet new];
        _runningOperations = [NSMutableArray new];
    }
    return self;
}

- (nullable id)loadImageWithURL:(nullable NSURL *)url
                      completed:(nullable void (^)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, XMImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL))completedBlock {

    // 防止传入url是字符串型
    if ([url isKindOfClass:NSString.class]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    
    if (![url isKindOfClass:NSURL.class]) {
        url = nil;
    }

    XMWebImageOperation *operation = [XMWebImageOperation new];
    operation.manager = self;
    
    BOOL isFailedUrl = NO;
    if (url) {
        @synchronized (self.failedURLs) {
            isFailedUrl = [self.failedURLs containsObject:url];
        }
    }
    
    // url空时候处理
    if (url.absoluteString.length == 0 || isFailedUrl) {
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
        
        [self callCompletionBlockForOperation:nil completion:completedBlock image:nil data:nil error:error cacheType:XMImageCacheTypeNone finished:YES url:url];
        return nil;
    }
    
    __weak XMWebImageOperation *weakOperation = operation;
    @synchronized (self.runningOperations) {
        [self.runningOperations addObject:operation];
    }
    //依据图片地址生成相对于的key
    NSString *key = [self cacheKeyForURL:url];
    // 查询图片状态
    operation.cacheOperation = [self.imageCache queryCacheOperationForKey:key done:^(UIImage * _Nullable cachedImage, NSData * _Nullable cachedData, XMImageCacheType cacheType) {
        if (operation.isCancelled) {
            [self safelyRemoveOperationFromRunning:operation];
            return;
        }
        
        //缓存为空，切代理方法为空或者代理返回YES,则执行下载图片操作
        if (!cachedImage && (![self.delegate respondsToSelector:@selector(imageManager:shouldDownloadImageForURL:)])) {

            XMImageDownloadToken *subOperationToken = [self.imageDownloader downloadImageWithURL:url completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (finished && image) {
                    [self.imageCache storeImage:image forKey:key toDisk:YES completion:nil];
                }
                [self callCompletionBlockForOperation:operation completion:completedBlock image:image data:data error:error cacheType:XMImageCacheTypeNone finished:finished url:url];
            }];
            operation.cancelBlock = ^{
                [self.imageDownloader cancel:subOperationToken];
                __strong __typeof(weakOperation) strongOperation = weakOperation;
                [self safelyRemoveOperationFromRunning:strongOperation];
            };
        } else if (cachedImage) {// 缓存不为空
            __strong __typeof(weakOperation) swOperation = weakOperation;
            [self callCompletionBlockForOperation:swOperation completion:completedBlock image:cachedImage data:cachedData error:nil cacheType:cacheType finished:YES url:url];
            [self safelyRemoveOperationFromRunning:operation];
            
        } else {// 缓存为空，切不允许下载
            __strong __typeof(weakOperation) swOperation = weakOperation;
            [self callCompletionBlockForOperation:swOperation completion:completedBlock image:nil data:nil error:nil cacheType:XMImageCacheTypeNone finished:YES url:url];
            [self safelyRemoveOperationFromRunning:operation];
        }
    }];
    return operation;
}

- (void)callCompletionBlockForOperation:(nullable id)operation
                             completion:(void(^)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, XMImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL))completionBlock
                                  image:(nullable UIImage *)image
                                   data:(nullable NSData *)data
                                  error:(nullable NSError *)error
                              cacheType:(XMImageCacheType)cacheType
                               finished:(BOOL)finished
                                    url:(nullable NSURL *)url {
    dispatch_main_async_safe(^{
        if ( completionBlock) {
            completionBlock(image, data, error, cacheType, finished, url);
        }
    });
}

- (void)safelyRemoveOperationFromRunning:(nullable XMWebImageOperation*)operation {
    @synchronized (self.runningOperations) {
        if (operation) {
            [self.runningOperations removeObject:operation];
        }
    }
}

- (nullable NSString *)cacheKeyForURL:(nullable NSURL *)url {
    if (!url) {
        return @"";
    }
    if (self.cacheKeyFilter) {
        return self.cacheKeyFilter(url);
    } else {
        return url.absoluteString;
    }
}
@end
