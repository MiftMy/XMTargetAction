//
//  XMOtherItemCell.h
//  XMDemo
//
//  Created by mifit on 2018/5/28.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMHomePageItemModel;

/*
 * 首页cell，二合一，减少耦合
 */
@interface UITableViewCell(XMOtherItemCell)
- (void)updateCellWithModel:(XMHomePageItemModel *)model;
@end
