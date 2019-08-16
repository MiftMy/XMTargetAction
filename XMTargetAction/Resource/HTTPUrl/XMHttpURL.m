//
//  XMHttpURL.m
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMHttpURL.h"

@implementation XMHttpURL
+ (NSString *)baseMovieUrl {
    return @"https://api.douban.com/v2/movie/";
}

+ (NSString *)baseLocUrl {
    return @"https://api.douban.com/v2/loc/";
}

+ (NSString *)basePhotoUrl {
    return @"https://gss3.bdstatic.com/";
}

/// 排名前250的电影地址
+ (NSString *)top250MoviesURL {
    return [[self baseMovieUrl]stringByAppendingString:@"top250"];
}

/// 正在热播电影地址
+ (NSString *)HitMoviesURL {
    return [[self baseMovieUrl]stringByAppendingString:@"in_theaters"];
}

/// 即将上映电影地址
+ (NSString *)upcomingMoviesURL {
    return [[self baseMovieUrl]stringByAppendingString:@"coming_soon"];
}

/// 城市列表地址
+ (NSString *)cityListURL {
    return [[self baseLocUrl]stringByAppendingString:@"list"];
}

/// 苍老师主页地址
+ (NSString *)teacherHomePageURL {
    return [[self basePhotoUrl]stringByAppendingString:@"9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=3d55cb20da00baa1ae214fe92679d277/d1160924ab18972b766f0606edcd7b899f510aa0.jpg"];
}

/// 相册图片地址1
+ (NSString *)teacherPhotoAlbumPic1URL {
    return [[self basePhotoUrl]stringByAppendingString:@"-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike180%2C5%2C5%2C180%2C60/sign=24fcaed30c0828387c00d446d9f0c264/472309f790529822718d3c0fdcca7bcb0b46d4bb.jpg"];
}

/// 相册图片地址2
+ (NSString *)teacherPhotoAlbumPic2URL {
    return [[self basePhotoUrl]stringByAppendingString:@"-fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike220%2C5%2C5%2C220%2C73/sign=b501aead04b30f242197e451a9fcba26/728da9773912b31b7ed9c8e58d18367adbb4e141.jpg"];
}

/// 相册图片地址3
+ (NSString *)teacherPhotoAlbumPic3URL {
    return [[self basePhotoUrl]stringByAppendingString:@"9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=e0ad791125738bd4d02cba63c0e2ecb3/4a36acaf2edda3cc46c0beec0ae93901203f92d1.jpg"];
}
@end
