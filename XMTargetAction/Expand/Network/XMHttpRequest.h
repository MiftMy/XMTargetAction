//
//  XMHttpRequest.h
//  AMotorcycle
//
//  Created by mifit on 2017/12/11.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMHttpRequest : NSObject
@property (nonatomic, copy) void(^progressBlock)(CGFloat progress);
@property (nonatomic, copy) void(^completedBlock)(id respondeObj, NSError *error);



+ (void)GET:(NSString *)urlStr completed:(void(^)(NSData *data, NSURLResponse *response, NSError *error))block;

+ (void)POST:(NSString *)urlStr param:(NSDictionary *)param completed:(void(^)(NSData *data, NSURLResponse *response, NSError *error))block;

+ (NSURLSessionDownloadTask *)download:(NSString *)urlStr
                              savePath:(NSString *)savePath
                             completed:(void(^)(NSURL *fileURL, NSURLResponse *response, NSError *error))block;

+ (NSURLSessionDownloadTask *)downloadResumeData:(NSData *)data
                                        savePath:(NSString *)savePath
                                       completed:(void(^)(NSURL *fileURL, NSURLResponse *response, NSError *error))block;

+ (void)cancelDownloadTask:(NSURLSessionDownloadTask *)task resumeData:(void(^)(NSData *data))block;


+ (void)upload:(NSString *)urlStr param:(NSDictionary *)param withData:(NSData *)data completed:(void(^)( NSError *error))block;


@end
