//
//  UIImageView+WebCache.m
//  XMDemo
//
//  Created by mifit on 2018/5/24.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "XMImageManager.h"
#import "XMImageDownloadOperation.h"
#import "objc/runtime.h"
#import "XMImageCache.h"

static char imageURLKey;
static char loadOperationKey;

#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

@interface UIImageView()

@end

@implementation UIImageView(WebCache)

- (void)setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder {
    [self internalSetImageWithURL:url placeholderImage:placeholder operationKey:url.absoluteString setImageBlock:nil completed:nil];
}

- (void)internalSetImageWithURL:(nullable NSURL *)url
                  placeholderImage:(nullable UIImage *)placeholder
                      operationKey:(nullable NSString *)operationKey
                     setImageBlock:(void(^)(UIImage * _Nullable image, NSData * _Nullable imageData))setImageBlock
                         completed:(nullable void(^)(UIImage * _Nullable image, NSError * _Nullable error, XMImageCacheType cacheType, NSURL * _Nullable imageURL))completedBlock {
    
    NSString *validOperationKey = operationKey?:NSStringFromClass([self class]);
    [self cancelImageLoadOperationWithKey:validOperationKey];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (placeholder) {
        dispatch_main_async_safe(^{
            [self setImage:placeholder imageData:nil basedOnClassOrViaCustomSetImageBlock:nil];
        });
    }
    
    if (url) {
        __weak __typeof(self)wself = self;
       
        id operation = [XMImageManager.sharedManager loadImageWithURL:url completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, XMImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            __strong __typeof (wself) sself = wself;
            if (!sself) {
                return;
            }
            dispatch_main_async_safe(^{
                if (!sself) {
                    return;
                }
                if (image) {
                    [sself setImage:image imageData:data basedOnClassOrViaCustomSetImageBlock:setImageBlock];
                } else {
                    if (placeholder) {
                        [sself setImage:placeholder imageData:nil basedOnClassOrViaCustomSetImageBlock:setImageBlock];
                    }
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType,url);
                }
            });
        }];
        [self setImageLoadOperation:operation forKey:validOperationKey];
    } else {
        dispatch_main_async_safe(^{
            if (completedBlock) {
                NSError *error = [NSError errorWithDomain:@"SDWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
                completedBlock(nil, error, XMImageCacheTypeNone, url);
            }
        });
    }
}

- (void)setImage:(UIImage *)image imageData:(NSData *)imageData basedOnClassOrViaCustomSetImageBlock:(void(^)(UIImage * _Nullable image, NSData * _Nullable imageData))setImageBlock {
    if (setImageBlock) {
        setImageBlock(image, imageData);
        return;
    }
    
    
    if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)self;
        imageView.image = image;
    }
    
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self;
        [button setImage:image forState:UIControlStateNormal];
    }
    
}

- (void)setImageLoadOperation:(nullable id)operation forKey:(nullable NSString *)key {
    if (key) {
        [self cancelImageLoadOperationWithKey:key];
        if (operation) {
            NSMutableDictionary *operationDictionary = [self operationDictionary];
            operationDictionary[key] = operation;
        }
    }
}

- (void)cancelImageLoadOperationWithKey:(nullable NSString *)key {
    // Cancel in progress downloader from queue
    NSMutableDictionary *operationDictionary = [self operationDictionary];
    id operations = operationDictionary[key];
    if (operations) {
        if ([operations isKindOfClass:[NSArray class]]) {
            for (id operation in operations) {
                if (operation) {
                    [operation cancel];
                }
            }
        } else {
            [(id) operations cancel];
        }
        [operationDictionary removeObjectForKey:key];
    }
}

#pragma mark -
- (NSMutableDictionary *)operationDictionary {
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &loadOperationKey);
    if (operations) {
        return operations;
    }
    operations = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, &loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return operations;
}
@end
