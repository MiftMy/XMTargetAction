//
//  XMVideoHotCellStyle1.m
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMVideoHotCellStyle1.h"
#import "UIImageView+WebCache.h"

@interface XMVideoHotCellStyle1()

@property (weak, nonatomic) IBOutlet UIImageView *imgBig;
@property (weak, nonatomic) IBOutlet UIImageView *imgMin;
@property (weak, nonatomic) IBOutlet UIImageView *imgSmall1;
@property (weak, nonatomic) IBOutlet UIImageView *imgSmall2;
@property (weak, nonatomic) IBOutlet UIImageView *imgSmall3;
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UILabel *videoDescription;
@property (weak, nonatomic) IBOutlet UILabel *videoScare;

@end


@implementation XMVideoHotCellStyle1

- (void)updateCellWithParam:(NSDictionary *)item {
    NSString *title = item[@"title"];// 标题

    NSArray *casts = item[@"casts"];//演员
    if (casts.count > 0) {
        NSDictionary *actor = casts[0];
        [self loadImageWithActior:actor at:0];
        if (casts.count > 1) {
            NSDictionary *actor = casts[1];
            [self loadImageWithActior:actor at:1];
            if (casts.count > 2) {
                NSDictionary *actor = casts[2];
                [self loadImageWithActior:actor at:2];
            }
        }
    }
    
    NSArray *directors = item[@"directors"];//导演
    if (directors.count > 0) {
        NSDictionary *director = directors[0];
        NSDictionary *imgs = director[@"avatars"];
        NSString *directorImgUrl = imgs[@"medium"];
        [self.imgMin setImageWithURL:[NSURL URLWithString:directorImgUrl] placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    }
    
    NSDictionary *images = item[@"images"];
    NSString *urlStr = images[@"large"];//海报
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.imgBig setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    
    
    
    NSDictionary *rating = item[@"rating"];
    NSString *averageRating = [NSString stringWithFormat:@"%.1f", [rating[@"average"]floatValue]];//评分
    
    self.videoName.text = title;//电影名称
    self.videoDescription.text = item[@"original_title"];//描述
    self.videoScare.text = averageRating;
}

- (void)loadImageWithActior:(NSDictionary *)actor at:(NSInteger)indx {
    UIImage *placeholder = [UIImage imageNamed:@"placeHolderImage"];
    NSDictionary *imgs = actor[@"avatars"];
    if ([imgs isKindOfClass:[NSDictionary class]]) {
        NSString *imgUrl = imgs[@"small"];//演员图片
        if (imgUrl) {
            if (indx == 0) {
                [self.imgSmall1 setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:placeholder];
            }
            if (indx == 1) {
                [self.imgSmall2 setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:placeholder];
            }
            if (indx == 2) {
                [self.imgSmall3 setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:placeholder];
            }
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
