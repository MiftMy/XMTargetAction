//
//  XMTestVC.m
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMTestVC.h"
#import "XMBaseMacro.h"
#import "UINavigationBar+Color.h"

@interface XMTestVC ()

@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIView *navBG;

@end

@implementation XMTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试VC";
    
    [self.navBar clearBGColor];
    self.navBG.backgroundColor = XMNGreenColor;
    self.navBG.tintColor = XMNBlueColor;
    [self.navBar titleColor:XMNBlueColor];
    [self statusTextBlackColor];
    
    
    /// 有个一bug 导航栏颜色深了一点。present出来的都深了一点。
}

- (IBAction)closePage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
