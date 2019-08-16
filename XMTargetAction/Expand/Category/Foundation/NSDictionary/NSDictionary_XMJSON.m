//
//  NSDictionary_XMJSON.m
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import "NSDictionary_XMJSON.h"

@implementation NSDictionary(XMJSON)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [self dictionaryWithData:jsonData];
}

+ (NSDictionary *)dictionaryWithData:(NSData *)data {
    if (data == nil) {
        return nil;
    }

    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
