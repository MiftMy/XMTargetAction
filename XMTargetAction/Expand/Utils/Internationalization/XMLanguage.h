//
//  XMLanguage.h
//  AreoxPlay
//
//  Created by mifit on 2016/10/20.
//  Copyright © 2016年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XMLocalizedString(key,alert)    ([XMLanguage localizeString:key])
#define XMResetLanguage(language)       ([XMLanguage resetCurrentLanguage:language])
#define XMCurrentLanguage               ([XMLanguage currentLanguage])

/*
 *  多国语言设置类。 可随系统先，然后手动设置
 */
@interface XMLanguage : NSObject
/// 获取当前设置的语言
+ (NSString *)currentLanguage;

/// 设置当前语言
+ (void)resetCurrentLanguage:(NSString *)language;

/// 国际化
+ (NSString *)localizeString:(NSString *)key;
@end
