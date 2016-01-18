//
//  NSString+CN2UTF8.h
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//  简便的将中文字符转化成UTF-8格式字符

#import <Foundation/Foundation.h>

@interface NSString (CN2UTF8)
///中文转UTF-8
+ (NSString *)CNToUTF8:(NSString *)str;

@end
