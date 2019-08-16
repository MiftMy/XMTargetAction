//
//  XMOtherItemCell.m
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMOtherItemCell.h"
#import "XMHomePageItemModel.h"
#import "XMBaseMacro.h"

@implementation UITableViewCell(XMOtherItemCell)

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateCellWithModel:(XMHomePageItemModel *)model {
    self.textLabel.text = model.title;
    if (model.cellType == XMCellTypeVideo) {
        self.imageView.image = [UIImage imageNamed:model.imgName];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.textLabel setTextColor:XMNGreenColor];
    }
    if (model.cellType == XMCellTypeOther) {
        [self.textLabel setTextColor:XMNBlueColor];
        self.tintColor = XMNGreenColor;
        self.accessoryType = UITableViewCellAccessoryDetailButton;
        NSString *showModeStr = model.showModeStr;
        if (!showModeStr) {
            if (model.showMode == XMVCShowModePush) {
                showModeStr = @"Push vc";
            }
            if (model.showMode == XMVCShowModePresent) {
                showModeStr = @"Present vc";
            }
            model.showModeStr = showModeStr;
        }
        self.detailTextLabel.text = showModeStr;
    }
}

@end
