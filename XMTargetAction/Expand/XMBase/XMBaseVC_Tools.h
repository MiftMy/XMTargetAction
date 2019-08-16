//
//  XMBaseVC_Tools.h
//  XMAppAuthorization
//
//  Created by mifit on 2018/5/9.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMBaseVC.h"

@interface XMBaseVC(XMBaseVC_Tools)

/*
 吐司
 */
- (void)toastMsg:(NSString *)msg;

/*
 *  弹出系统的提示框
 */
- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg actionTitles:(NSArray *)subTitles cancelBlock:(void(^)(void))cBlock sureBlock:(void(^)(void))sBlock;

/*
 *  弹出系统的action sheet
 */
- (void)showActionSheet:(NSString *)title msg:(NSString *)msg actionTitles:(NSArray *)subTitles actionBlock:(void(^)(NSInteger actionIndex))cBlock;


@end
