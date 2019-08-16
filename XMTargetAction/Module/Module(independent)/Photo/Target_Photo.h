//
//  Target_Photo.h
//  XMDemo
//
//  Created by mifit on 2018/5/29.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target_Photo : NSObject
/*
 *  苍老师相册vc
 */
- (UIViewController *)Action_teacherPhotoViewController:(NSDictionary *)param;

/*
 *  苍老师主页vc
 */
- (UIViewController *)Action_teacherHomeViewController:(NSDictionary *)param;
@end
