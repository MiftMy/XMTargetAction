//
//  UIImageView+WebCache.h
//  XMDemo
//
//  Created by mifit on 2018/5/24.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView(WebCache)
- (void)setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder;
@end
