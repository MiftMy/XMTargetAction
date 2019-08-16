//
//  UIImage+Tools.h
//  XMDemo
//
//  Created by mifit on 2018/5/24.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    图片和NSData转换、去掉透明度
 
    支持格式jpeg、png、gif
 */
@interface UIImage(UIImage_Tools)

+ (nullable UIImage *)scaledImageForKey:(NSString * _Nullable) key image:(UIImage * _Nullable)image;

/// 是否gif图片
- (BOOL)isGIF;

/// 依据图片和其数据，获取图片数据
+ (nullable NSData *)dataFromImage:(nullable UIImage *)img data:(nullable NSData *)data;

/// 数据转图片
+ (nullable UIImage *)imageFromData:(nullable NSData *)data;

/// 解码去掉透明度数据
+ (nullable UIImage *)decodedImageWithImage:(nullable UIImage *)image;
@end
