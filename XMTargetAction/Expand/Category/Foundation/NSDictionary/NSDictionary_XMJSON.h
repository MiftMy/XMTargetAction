//
//  NSDictionary_XMJSON.h
//  XMDemo
//
//  Created by mifit on 2018/5/23.
//  Copyright © 2018年 Mifit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(XMJSON)
/*
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/*
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param   data JSON格式的data
 * @return  返回字典
 */
+ (NSDictionary *)dictionaryWithData:(NSData *)data;
@end
