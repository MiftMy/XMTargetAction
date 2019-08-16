//
//  XMBaseVC.h
//  AMotorcycle
//
//  Created by mifit on 2017/12/11.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMBaseVC : UIViewController
//布局在safeView上，适配iPhone X
//@property (nonatomic, strong) UIView *safeView;

/// 是否旋屏
@property (nonatomic, assign) BOOL isRotation;
/**
 设置当前vc的方向
 */
@property (nonatomic,assign) UIInterfaceOrientationMask supperts;
@property (nonatomic,assign) UIInterfaceOrientation preFirst;

/// 将要转到哪个方向，不设置随设备方向
@property (nonatomic, copy) UIInterfaceOrientationMask (^willRotationBlock)(void);
/// 已经转到那个方向
@property (nonatomic, copy) void (^didRotationBlock)(void);

/// 隐藏键盘
- (void)hideKeyboard;

/// 状态栏颜色
- (void)statusTextWhiteColor;
- (void)statusTextBlackColor;
- (void)setStatusBarBackgroundColor:(UIColor *)color;

/// 打开app内部权限设置。未请求过权限的打开系统设置。iOS 8以后
- (BOOL)openAppSetting;

/*
    push到指定vc
 */
- (void)pushToVC:(NSString *)vcName sb:(NSString *)sbName;

/*
    从sb加载vc
 */
- (id)loadVC:(NSString *)vcName sb:(NSString *)sbName;
@end
