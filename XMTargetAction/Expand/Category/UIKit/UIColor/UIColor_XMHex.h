//
//  UIColor_XMHex.h
//  XMAppAuthorization
//
//  Created by mifit on 2018/5/7.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(XMHex)
// hex字符串转。 型如：0X3498c8、 0x3498c8、 #3498c8、 3498c8
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
