//
//  XMVideoHotCellStyle2.m
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMVideoHotCellStyle2.h"
#import "UIImageView+WebCache.h"

@interface XMVideoHotCellStyle2()

@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UILabel *videoScare;
@property (weak, nonatomic) IBOutlet UILabel *videoType;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end



@implementation XMVideoHotCellStyle2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCellWithParam:(NSDictionary *)item {
    NSString *title = item[@"title"];// 标题
    NSArray *genres = item[@"genres"];// 标签

    
    NSDictionary *images = item[@"images"];
    NSString *urlStr = images[@"large"];//海报
    NSURL *url = [NSURL URLWithString:urlStr];
    [self.img setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolderImage"]];
    
    NSDictionary *rating = item[@"rating"];
    NSString *averageRating = [NSString stringWithFormat:@"%.1f", [rating[@"average"]floatValue]];//评分
    
    self.videoName.text = title;// 电影名称
    NSString *description = @"标签:";//标签
    for (NSString *tem in genres) {
        description = [description stringByAppendingFormat:@"%@/", tem];
    }
    self.videoType.text = description;
    self.videoScare.text = averageRating;
}
@end
