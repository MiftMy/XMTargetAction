//
//  XMTeacherPhotoVC.m
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMTeacherPhotoVC.h"
#import "UIImageView+WebCache.h"

@interface XMTeacherPhotoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;

@end

@implementation XMTeacherPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"苍老师相册";
    UIImage *placeholder = [UIImage imageNamed:@"placeHolderImageB"];
    NSURL *img1URL = [NSURL URLWithString:self.img1Url];
    NSURL *img2URL = [NSURL URLWithString:self.img2Url];
    NSURL *img3URL = [NSURL URLWithString:self.img3Url];
//    [self.img1 sd_setImageWithURL:img1URL placeholderImage:placeholder];
//    [self.img2 sd_setImageWithURL:img2URL placeholderImage:placeholder];
//    [self.img3 sd_setImageWithURL:img3URL placeholderImage:placeholder];
    
    [self.img1 setImageWithURL:img1URL placeholderImage:placeholder];
    [self.img2 setImageWithURL:img2URL placeholderImage:placeholder];
    [self.img3 setImageWithURL:img3URL placeholderImage:placeholder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
