//
//  XMTabBarBaseC.h
//  XMAppAuthorization
//
//  Created by mifit on 2018/5/9.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTabBarBaseC : UITabBarController

//设置vc，使用 self.viewControllers
//默认选中哪个，使用self.selectedIndex

/// 设置文字。请设置viewControllers之后再设置。下面同理
- (void)setTabBarTitles:(NSArray *)titles;
/// 设置TabBar图片。图片放Assets内，传图片名。
- (void)setTabBarImage:(NSArray *)normalImgs selectedImages:(NSArray *)selImgs;
- (void)setTabBarTitles:(NSArray *)titles image:(NSArray *)normalImgs selectedImages:(NSArray *)selImgs;
@end
