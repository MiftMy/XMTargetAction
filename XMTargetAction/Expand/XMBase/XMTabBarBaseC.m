//
//  XMTabBarBaseC.m
//  XMAppAuthorization
//
//  Created by mifit on 2018/5/9.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMTabBarBaseC.h"

@interface XMTabBarBaseC ()

@end

@implementation XMTabBarBaseC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.viewControllers;
    //self.selectedIndex;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTabBarTitles:(NSArray *)titles {
    NSInteger indx = 0;
    for (UITabBarItem *item in self.tabBar.items) {
        if (indx < titles.count) {
            item.title = titles[indx];
        }
        indx++;
    }
}

- (void)setTabBarImage:(NSArray *)normalImgs selectedImages:(NSArray *)selImgs {
    NSInteger indx = 0;
    for (UITabBarItem *item in self.tabBar.items) {
        if (indx < normalImgs.count) {
            item.image = [UIImage imageNamed:normalImgs[indx]];
        }
        if (indx < selImgs.count) {
            item.selectedImage = [[UIImage imageNamed:selImgs[indx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        indx++;
    }
}

- (void)setTabBarTitles:(NSArray *)titles image:(NSArray *)normalImgs selectedImages:(NSArray *)selImgs {
    NSInteger indx = 0;
    for (UITabBarItem *item in self.tabBar.items) {
        if (indx < titles.count) {
            item.title = titles[indx];
        }
        if (indx < normalImgs.count) {
            item.image = [UIImage imageNamed:normalImgs[indx]];
        }
        if (indx < selImgs.count) {
            item.selectedImage = [[UIImage imageNamed:selImgs[indx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        indx++;
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

@end
