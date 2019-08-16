//
//  XMImageDownloader.h
//  XMDemo
//
//  Created by mifit on 2018/5/24.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XMImageDownloadToken : NSObject

@property (nonatomic, strong, nullable) NSURL *url;
@property (nonatomic, strong, nullable) id downloadOperationCancelToken;

@end


@interface XMImageDownloader : NSObject
@property (assign, nonatomic) NSTimeInterval downloadTimeout;
@property (strong, nonatomic, nullable) NSDictionary *HTTPHeaders;
@property (strong, nonatomic, nonnull) NSOperationQueue *downloadQueue;
@property (assign, nonatomic) BOOL shouldDecompressImages;
@property (assign, nonatomic) NSInteger executionOrder;

+ (nonnull instancetype)sharedDownloader;
- (void)cancel:(nullable XMImageDownloadToken *)token;
- (nullable XMImageDownloadToken *)downloadImageWithURL:(nullable NSURL *)url
                                              completed:(void(^)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished))completedBlock;
@end
