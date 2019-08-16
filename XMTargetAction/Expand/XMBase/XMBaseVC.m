//
//  XMBaseVC.m
//  AMotorcycle
//
//  Created by mifit on 2017/12/11.
//  Copyright © 2017年 Mifit. All rights reserved.
//

#import "XMBaseVC.h"
//#import "Masonry.h"
#import "XMBaseMacro.h"

@interface XMBaseVC ()
{
    BOOL isViewAppear;
}

@property (nonatomic, assign) UIStatusBarStyle statusStyle;
@end

@implementation XMBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //save area
//    self.safeView = [UIView new];
//    [self.view addSubview:self.safeView];
//    [self.safeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (@available(iOS 11.0, *)) {
//            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
//            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
//            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
//            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//        } else {
//            make.edges.equalTo(self.view);
//        }
//    }];
    
    isViewAppear = NO;
    _isRotation = YES;
    self.statusStyle = UIStatusBarStyleLightContent;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.preFirst == UIInterfaceOrientationUnknown ) {
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationUnknown || orientation == UIDeviceOrientationPortrait || UIDeviceOrientationIsPortrait(orientation)) {
            self.preFirst = UIInterfaceOrientationPortrait;
        }
        if (orientation == UIDeviceOrientationFaceUp || orientation == UIDeviceOrientationFaceDown || UIDeviceOrientationIsLandscape(orientation)) {
            self.preFirst = UIInterfaceOrientationPortrait;
        }
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeLeft || UIDeviceOrientationIsLandscape(orientation)) {
            self.preFirst = UIInterfaceOrientationLandscapeRight;
        }
    }
    self.supperts = UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight;
    
//    [self setStatusBarBackgroundColor:XMNGreenColor];
}

- (void)viewWillAppear:(BOOL)animated{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation != UIDeviceOrientationUnknown) {
        NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:self.preFirst];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    isViewAppear = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ratation
- (BOOL)shouldAutorotate {
    return self.isRotation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (isViewAppear) {
        if (self.willRotationBlock) {
            return self.willRotationBlock();
        } else {
            [self updateOrientation];
        }
        if (self.didRotationBlock) {
            self.didRotationBlock();
        }
    }
    return self.supperts;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.preFirst;
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSString *str =  NSStringFromCGSize(size);
    NSLog(@"Transition to size:%@", str);
}

//依据需求改动
- (void)updateOrientation {
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
            self.preFirst = UIInterfaceOrientationPortrait;
            self.supperts = UIInterfaceOrientationMaskPortrait;
            NSLog(@"device orientation: portrait");
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            self.preFirst = UIInterfaceOrientationLandscapeRight;
            self.supperts = UIInterfaceOrientationMaskLandscapeRight;
            NSLog(@"device orientation: landscape right");
            break;
        default:
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/// nav下，要实现- (UIViewController *)childViewControllerForStatusBarStyle
- (UIStatusBarStyle)preferredStatusBarStyle{
    return self.statusStyle;
}

//- (void)setNeedsStatusBarAppearanceUpdate
#pragma mark - public
- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)statusTextWhiteColor {
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.statusStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)statusTextBlackColor {
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.statusStyle = UIStatusBarStyleDefault;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (BOOL)openAppSetting {
    //跳转到应用下权限设置 iOS 8以后使用。如果没有请求过权限，则跳转到系统设置。
    NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        if (XMSYSTEM_VERSION_BIGTHAN(10.0)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        return YES;
    } else {
        return NO;
    }
}

- (void)pushToVC:(NSString *)vcName sb:(NSString *)sbName {
    if (!vcName) {
        return;
    }
    id vc = nil;
    if (sbName) {
        vc = [[UIStoryboard storyboardWithName:sbName bundle:nil]instantiateViewControllerWithIdentifier:vcName];
    } else {
        Class cl = NSClassFromString(vcName);
        vc = [[cl alloc]init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


- (id)loadVC:(NSString *)vcName sb:(NSString *)sbName{
    id vc = [[UIStoryboard storyboardWithName:sbName bundle:nil]instantiateViewControllerWithIdentifier:vcName];
    return vc;
}
@end
