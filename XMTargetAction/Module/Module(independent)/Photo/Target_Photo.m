//
//  Target_Photo.m
//  XMDemo
//
//  Created by mifit on 2018/5/29.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "Target_Photo.h"
#import "XMTeacherHomeVC.h"
#import "XMTeacherPhotoVC.h"

@implementation Target_Photo
- (UIViewController *)Action_teacherPhotoViewController:(NSDictionary *)param {
    XMTeacherPhotoVC *vc = [[UIStoryboard storyboardWithName:@"TeacherPhoto" bundle:nil]instantiateViewControllerWithIdentifier:@"XMTeacherPhotoVC"];
    NSArray *imgList = param[@"images"];
    if (imgList.count > 0) {
        vc.img1Url = imgList[0];
        if (imgList.count > 1) {
            vc.img2Url = imgList[1];
            if (imgList.count > 2) {
                vc.img3Url = imgList[2];
            }
        }
    }
    
    return vc;
}

- (UIViewController *)Action_teacherHomeViewController:(NSDictionary *)param {
    XMTeacherHomeVC *vc = [[UIStoryboard storyboardWithName:@"TeacherHome" bundle:nil]instantiateViewControllerWithIdentifier:@"XMTeacherHomeVC"];
    vc.iconUrl = param[@"imgUrl"];
    return vc;
}
@end
