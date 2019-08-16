//
//  XMBaseVC_Tools.m
//  XMAppAuthorization
//
//  Created by mifit on 2018/5/9.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "XMBaseVC_Tools.h"
#import "XMInfoAlert.h"


@implementation XMBaseVC(XMBaseVC_Tools)

- (void)toastMsg:(NSString *)msg {
    [XMInfoAlert showInfo_3:msg bgColor:[UIColor lightGrayColor].CGColor inView:self.view vertical:0.5];
}

- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg actionTitles:(NSArray *)subTitles cancelBlock:(void(^)(void))cBlock sureBlock:(void(^)(void))sBlock {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    NSString *cancelTitle = @"取消";
    if (subTitles.count >= 1) {
        cancelTitle = subTitles[0];
    }
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cBlock) {
            cBlock();
        }
    }];
    NSString *sureTitle = @"确定";
    if (subTitles.count >= 2) {
        sureTitle = subTitles[1];
    }
    UIAlertAction *actionSure = [UIAlertAction actionWithTitle:subTitles[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [vc dismissViewControllerAnimated:YES completion:nil];
        if (sBlock) {
            sBlock();
        }
    }];
    [vc addAction:actionCancel];
    [vc addAction:actionSure];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)showActionSheet:(NSString *)title msg:(NSString *)msg actionTitles:(NSArray *)subTitles actionBlock:(void(^)(NSInteger actionIndex))cBlock {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger indx = 0; indx <= subTitles.count; indx++) {
        NSString *title = nil;
        UIAlertActionStyle style = UIAlertActionStyleDefault;
        if (indx == subTitles.count) {
            title = @"取消";
            style = UIAlertActionStyleCancel;
        } else{
            title = subTitles[indx];
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
            [vc dismissViewControllerAnimated:YES completion:nil];
            if (cBlock) {
                NSInteger indx = 0;
                for (NSString *st in subTitles) {
                    if ([st isEqualToString:action.title]) {
                        break;
                    }
                    indx++;
                }
                cBlock(indx);
            }
        }];
        [vc addAction:action];
    }

    [self presentViewController:vc animated:YES completion:nil];
}

@end
