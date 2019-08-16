//
//  XMMediator+Photo.h
//  XMDemo
//
//  Created by mifit on 2018/5/29.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMMediator.h"

@interface XMMediator(Photo)
/// 苍老师主页   imgUrl：海报地址
- (UIViewController *)Mediator_teacherHomeVC:(NSString *)imgUrl;

/// 苍老师相册   photoList：图片地址，字符串型。
- (UIViewController *)Mediator_teacherPhotoVC:(NSArray *)photoList;
@end
