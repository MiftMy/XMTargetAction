//
//  XMHttpRequest.m
//  AMotorcycle
//
//  Created by mifit on 2017/12/11.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import "XMHttpRequest.h"
@interface XMHttpRequest()
<
NSURLSessionDelegate
>
{
    NSURLSessionConfiguration *defConfiguration;
}
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSOperationQueue *sessionQueue;
@property (nonatomic, strong) NSMutableData *recData;
@property (nonatomic, copy) NSString *savePath;
@end
@implementation XMHttpRequest
#pragma mark - 类方法
+ (void)GET:(NSString *)urlStr
  completed:(void(^)(NSData *data, NSURLResponse *response, NSError *error))block
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (block) {
            block(data, response, error);
        }
    }];
    [sessionDataTask resume];
}

+ (void)POST:(NSString *)urlStr
       param:(NSDictionary *)param
   completed:(void(^)(NSData *data, NSURLResponse *response, NSError *error))block
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[self bodyWithParam:param]dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (block) {
            block(data, response, error);
        }
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
    }];
    [sessionDataTask resume];
}

+ (NSURLSessionDownloadTask *)download:(NSString *)urlStr
                              savePath:(NSString *)savePath
                             completed:(void(^)(NSURL *fileURL, NSURLResponse *response, NSError *error))block
{
    NSURL *url = [NSURL URLWithString:urlStr] ;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        NSURL *pathUrl = [NSURL fileURLWithPath:savePath];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:pathUrl error:nil];
        if (block) {
            block(pathUrl, response, error);
        }
    }];
    [task resume];
    return task;
}

+ (NSURLSessionDownloadTask *)downloadResumeData:(NSData *)data
                                        savePath:(NSString *)savePath
                                       completed:(void(^)(NSURL *fileURL, NSURLResponse *response, NSError *error))block
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithResumeData:data completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSURL *pathUrl = [NSURL fileURLWithPath:savePath];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:pathUrl error:nil];
        if (block) {
            block(pathUrl, response, error);
        }
    }];
    [task resume];
    return task;
}

+ (void)cancelDownloadTask:(NSURLSessionDownloadTask *)task resumeData:(void(^)(NSData *data))block {
    [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        if (block) {
            block(resumeData);
        }
    }];
}

+ (void)upload:(NSString *)urlStr
         param:(NSDictionary *)param
      withData:(NSData *)data
     completed:(void(^)( NSError *error))block
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[self bodyWithParam:param]dataUsingEncoding:NSUTF8StringEncoding];

    [[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (block) {
            block(error);
        }
    }];
}

+ (NSString *)bodyWithParam:(NSDictionary *)param {
    NSMutableString *bodyStr = [NSMutableString new];
    NSInteger keyCount = 0;
    for (NSString *key in param) {
        if (keyCount != 0) {
            [bodyStr appendString:@"&"];
        }
        [bodyStr appendString:[NSString stringWithFormat:@"%@=%@", key, param[key]]];
    }
    return bodyStr;
}

#pragma mark - 成员方法
- (NSURLSession *)session {
    if (!_session) {
        defConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:defConfiguration delegate:self delegateQueue:self.sessionQueue];
    }
    return _session;
}

- (NSOperationQueue *)sessionQueue {
    if (!_sessionQueue) {
        _sessionQueue = [[NSOperationQueue alloc]init];
    }
    return _sessionQueue;
}

- (NSMutableData *)recData {
    if (!_recData) {
        _recData = [NSMutableData data];
    }
    return _recData;
}

- (void)post:(NSString *)urlStr param:(NSDictionary *)param {
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[XMHttpRequest bodyWithParam:param]dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    [task resume];
}

- (void)download:(NSString *)urlStr {
    
}
#pragma mark -- NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    //【注意：此处需要允许处理服务器的响应，才会继续加载服务器的数据。 若在接收响应时需要对返回的参数进行处理(如获取响应头信息等),那么这些处理应该放在这个允许操作的前面。
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    if (self.progressBlock) {
        CGFloat progress = dataTask.countOfBytesReceived / 1.0 / dataTask.countOfBytesExpectedToReceive;
        self.progressBlock(progress);
    }
    [self.recData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (self.completedBlock) {
        self.completedBlock(self.recData, error);
    }
}

#pragma mark NSURLSession download Delegate
//恢复下载位置
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

//下载进度
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    CGFloat progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite; NSLog(@"%f",progress);
}

//下载完成
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSURL *fileURL = nil;
    if (self.savePath) {
        fileURL = [NSURL fileURLWithPath:self.savePath];
    } else {
        NSString *filePath = [NSTemporaryDirectory()stringByAppendingPathComponent:[location lastPathComponent]];
        fileURL = [NSURL fileURLWithPath:filePath];
    }
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:fileURL error:nil];
}

@end
