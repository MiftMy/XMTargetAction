//
//  Target_Video.m
//  XMDemo
//
//  Created by mifit on 2018/5/30.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "Target_Video.h"
#import "XMVideoListVC.h"

@implementation Target_Video
- (UIViewController *)Action_movieListViewController:(NSDictionary *)param {
    XMVideoListVC *vc = [[UIStoryboard storyboardWithName:@"VideoList" bundle:nil]instantiateViewControllerWithIdentifier:@"XMVideoListVC"];
    vc.movieListUrl = param[@"movieListUrl"];
    return vc;
}
@end
