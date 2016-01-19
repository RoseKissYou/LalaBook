//
//  NSString+SubstringBySpace.m
//  N+
//
//  Created by hy1 on 16/1/19.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "NSString+SubstringBySpace.h"

@implementation NSString (SubstringBySpace)

+ (NSString *)getSubstring:(NSString *)str{
    NSArray *arr = [str componentsSeparatedByString:@" "];
    NSString *result = [arr[0] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    return result;
}

@end
