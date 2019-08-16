//
//  XMHttpURL.h
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMHttpURL : NSObject

/*
 *  排名前250的电影地址
 *
 *  参数：
 *  @param start    起始位置
 *  @param count   影片个数
 */
+ (NSString *)top250MoviesURL;

/*
 *  正在热播电影地址
 *
 *  参数：
 *  @param start    起始位置
 *  @param count   影片个数
 */
+ (NSString *)HitMoviesURL;

/*
 *  即将上映电影地址
 *
 *  参数：
 *  @param start    起始位置
 *  @param count   影片个数
 */
+ (NSString *)upcomingMoviesURL;

/*
 *  城市列表地址
 *
 *  参数：
 *  @param start   起始位置
 *  @param count   城市请求个数
 */
+ (NSString *)cityListURL;

/// 苍老师主页图片地址
+ (NSString *)teacherHomePageURL;

/// 相册图片地址1
+ (NSString *)teacherPhotoAlbumPic1URL;

/// 相册图片地址2
+ (NSString *)teacherPhotoAlbumPic2URL;

/// 相册图片地址3
+ (NSString *)teacherPhotoAlbumPic3URL;

@end
