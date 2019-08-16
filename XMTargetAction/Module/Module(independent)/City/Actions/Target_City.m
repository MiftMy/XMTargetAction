//
//  Target_City.m
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "Target_City.h"
#import "XMCityListVC.h"
#import "XMTestVC.h"

@implementation Target_City

- (UIViewController *)Action_cityListViewController:(NSDictionary *)param {
    XMCityListVC *vc = [[UIStoryboard storyboardWithName:@"CityList" bundle:nil]instantiateViewControllerWithIdentifier:@"XMCityListVC"];
    return vc;
}

- (UIViewController *)Action_testViewController:(NSDictionary *)param {
    XMTestVC *vc = [[UIStoryboard storyboardWithName:@"Test" bundle:nil]instantiateViewControllerWithIdentifier:@"XMTestVC"];
    return vc;
}
@end
