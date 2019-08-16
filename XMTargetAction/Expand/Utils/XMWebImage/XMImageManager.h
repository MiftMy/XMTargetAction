//
//  XMImageManager.h
//  XMDemo
//
//  Created by mifit on 2018/5/24.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XMImageCache.h"
#import "XMImageDownloader.h"


@class XMImageManager, XMWebImageOperation;

@protocol XMImageManagerProtocol <NSObject>
@optional
- (BOOL)imageManager:(nonnull XMImageManager *)imageManager shouldDownloadImageForURL:(nullable NSURL *)imageURL;
@end

@interface XMImageManager : NSObject
@property (nonatomic, weak, null_unspecified) id<XMImageManagerProtocol> delegate;
@property (strong, nonatomic, nullable) XMImageDownloader *imageDownloader;

+ (nonnull instancetype)sharedManager;
- (nullable NSString *)cacheKeyForURL:(nullable NSURL *)url;
- (void)safelyRemoveOperationFromRunning:(nullable XMWebImageOperation*)operation;
- (nullable id)loadImageWithURL:(nullable NSURL *)url
               completed:(nullable void (^)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, XMImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL))completedBlock;
@end
