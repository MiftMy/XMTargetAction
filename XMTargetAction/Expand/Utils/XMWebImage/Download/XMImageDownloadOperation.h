//
//  XMImageDownloadOperation.h
//  XMDemo
//
//  Created by mifit on 2018/5/25.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


extern NSString * _Nonnull const XMImageDownloadStartNotification;
extern NSString * _Nonnull const XMImageDownloadReceiveResponseNotification;
extern NSString * _Nonnull const XMImageDownloadStopNotification;
extern NSString * _Nonnull const XMImageDownloadFinishNotification;


/*
 *  下载完成回调block
 * @param image     下载完成图片
 * @param data      下载完成图片
 * @param error     下载错误
 * @param finished  是否下载完成
 */
typedef void(^XMCompletedBlock)(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished);

/*
 *  下载进度回调block
 * @param receivedSize     当前下载总字节
 * @param expectedSize     需要下载的总字节
 * @param targetURL        目标地址
 */
typedef void(^XMProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL);


@interface XMImageDownloadOperation : NSOperation <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
@property (strong, nonatomic, readonly, nullable) NSURLRequest *request;

@property (strong, nonatomic, readonly, nullable) NSURLSessionTask *dataTask;

@property (nonatomic, strong, nullable) NSURLCredential *credential;

/// 是否需要编码图片，去掉透明度
@property (assign, nonatomic) BOOL shouldDecompressImages;
- (BOOL)cancel:(nullable id)token;

- (nonnull instancetype)initWithRequest:(nullable NSURLRequest *)request
                              inSession:(nullable NSURLSession *)session;

- (nullable id)addHandlersForProgress:(nullable XMProgressBlock)progressBlock
                            completed:(nullable XMCompletedBlock)completedBlock;
@end
