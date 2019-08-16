//
//  XMTeacherHomeVC.m
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMTeacherHomeVC.h"
#import "UIImageView+WebCache.h"
#import "UINavigationBar+Color.h"
#import "XMBaseMacro.h"

@interface XMTeacherHomeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *homeIcon;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIView *navBG;

@end

@implementation XMTeacherHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *imageUrl = [NSURL URLWithString:self.iconUrl];
    [self.homeIcon setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeHolderImageB"]];
    
    // 此处参数组件化时候需要传入
    self.navBG.backgroundColor = XMNGreenColor;
    self.navBG.tintColor = XMNBlueColor;
    [self.navBar titleColor:XMNBlueColor];
    [self.navBar clearBGColor];
    [self statusTextBlackColor];
}

- (IBAction)closePage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
