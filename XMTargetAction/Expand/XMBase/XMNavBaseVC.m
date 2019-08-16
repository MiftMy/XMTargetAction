//
//  XMNavBaseVC.m
//  XMAppAuthorization
//
//  Created by mifit on 2018/5/9.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMNavBaseVC.h"
#import "XMBaseMacro.h"

@interface XMNavBaseVC ()

@property (nonatomic, strong) NSMutableDictionary *titleAttributes;
@end

@implementation XMNavBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateBackgroundColor:XMNGreenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearNavBarBackground {
//    self.navigationBar.translucent = NO;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(36, 36), NO, 0.0);
    UIImage *blankImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationBar setBackgroundImage:blankImage forBarMetrics:UIBarMetricsDefault];
    //不设置shadow则有条阴影线
    self.navigationBar.shadowImage = blankImage;
}

- (void)updateBackgroundColor:(UIColor *)color {
    [self.navigationBar setBarTintColor:color];
}

- (void)updateBackgroundImage:(UIImage *)image {
    [self.navigationBar setBackgroundImage:image forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
}

- (void)updateShadowImage:(UIImage *)image {
    self.navigationBar.shadowImage = image;
}

- (void)updateTinColor:(UIColor *)color {
    [self.navigationBar setTintColor:color];
}

- (NSMutableDictionary *)titleAttributes {
    if (!_titleAttributes) {
        _titleAttributes = [NSMutableDictionary dictionary];
    }
    return _titleAttributes;
}

- (void)updateTitleSize:(NSInteger)size {
    UIFont *font = [UIFont systemFontOfSize:size];
    self.titleAttributes[NSFontAttributeName] = font;
    [self updateTitleAttributes:self.titleAttributes];
}

- (void)updateTitleColor:(UIColor *)color {
    self.titleAttributes[NSForegroundColorAttributeName] = color;
    [self updateTitleAttributes:self.titleAttributes];
}

- (void)updateTitleAttributes:(NSDictionary *)attr {
    [self.navigationBar setTitleTextAttributes:attr];
}

/// 没有的话，nav下所有vc状态栏颜色都由本nav控制
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
