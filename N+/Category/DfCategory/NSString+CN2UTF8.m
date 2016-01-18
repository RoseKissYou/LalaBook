//
//  NSString+CN2UTF8.m
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "NSString+CN2UTF8.h"

@implementation NSString (CN2UTF8)

+ (NSString *)CNToUTF8:(NSString *)str{
    return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
