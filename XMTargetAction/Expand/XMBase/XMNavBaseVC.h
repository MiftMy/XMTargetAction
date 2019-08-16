//
//  XMNavBaseVC.h
//  XMAppAuthorization
//
//  Created by mifit on 2018/5/9.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMNavBaseVC : UINavigationController
/// 背景色透明
- (void)clearNavBarBackground;

/// 设置背景色，透明无效。
- (void)updateBackgroundColor:(UIColor *)color;
- (void)updateBackgroundImage:(UIImage *)image;

/// 阴影图片
- (void)updateShadowImage:(UIImage *)image;


/// 填充item颜色
- (void)updateTinColor:(UIColor *)color;

/// 设置title样式   例如：NSFontAttributeName
- (void)updateTitleSize:(NSInteger)size;
- (void)updateTitleColor:(UIColor *)color;
- (void)updateTitleAttributes:(NSDictionary *)attr;

@end
