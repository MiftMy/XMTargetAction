//
//  XMLanguage.m
//  AreoxPlay
//
//  Created by mifit on 2016/10/20.
//  Copyright © 2016年 Mifit. All rights reserved.
//

#import "XMLanguage.h"

#define SystemCURR_LANG                        ([[NSLocale preferredLanguages] objectAtIndex:0])

@interface XMLanguage()

@end

static NSString *currentLanguage = nil;
static NSBundle *bundle = nil;

@implementation XMLanguage

+ (NSString *)DPLocalizedString:(NSString *)translation_key {
    NSString *language = SystemCURR_LANG;
    NSString * s = XMLocalizedString(translation_key, nil);
    if (![language isEqual:@"en"] && ![language isEqual:@"zh-Hans"]) {
        NSString * path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        NSBundle * languageBundle = [NSBundle bundleWithPath:path];
        s = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
    }
    return s;
}

+ (NSString *)currentLanguage {
    if (!currentLanguage) {
        NSString *tem = [[NSUserDefaults standardUserDefaults]valueForKey:@"kAPCurrentLanguage"];
        if (!tem) {
            tem = SystemCURR_LANG;
        }
        NSString *language = nil;
        if ([tem hasPrefix:@"zh-Hans"]) {
            language = @"zh-Hans";
        }
        if ([tem hasPrefix:@"en"]) {
            language = @"en";
        }
        if ([tem hasPrefix:@"zh-Hant-HK"]) {
            language = @"zh-Hant-TW";
        }
        if ([tem hasPrefix:@"zh-Hant-TW"]) {
            language = @"zh-Hant-TW";
        }
        if (language == nil) {
            language = @"en";
        }
        currentLanguage = language;
    }
    return currentLanguage;
}

+ (void)resetCurrentLanguage:(NSString *)language {
    currentLanguage = language;
    NSString *path = [[ NSBundle mainBundle ] pathForResource:language ofType:@"lproj" ];
    if (!path) {
        path = [[ NSBundle mainBundle ] pathForResource:@"zh-Hans" ofType:@"lproj" ];
        currentLanguage = @"zh-Hans";
    }
    bundle = [NSBundle bundleWithPath:path];
    [[NSUserDefaults standardUserDefaults] setValue:language forKey:@"kAPCurrentLanguage"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"kAPLanguageChange" object:language];
}

+ (NSString *)localizeString:(NSString *)key alter:(NSString *)alternate {
    if (bundle == nil) {
        NSString *language = [self currentLanguage];
        NSString *path = [[ NSBundle mainBundle ] pathForResource:language ofType:@"lproj" ];
        bundle = [NSBundle bundleWithPath:path];
    }
    
    return [bundle localizedStringForKey:key value:alternate table:nil];
}

+ (NSString *)localizeString:(NSString *)key{
    return [self localizeString:key alter:nil];
}
@end
