//
//  UINavigationBar+Color.m
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "UINavigationBar+Color.h"

@implementation UINavigationBar(Color)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)clearBGColor {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 36), NO, 0.0);
    UIImage *blankImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:blankImage forBarMetrics:UIBarMetricsDefault];
    //不设置shadow则有条阴影线
    self.shadowImage = blankImage;
}

- (void)titleColor:(UIColor *)color {
    NSDictionary *attr = @{NSForegroundColorAttributeName:color};
    [self setTitleTextAttributes:attr];
}
@end
