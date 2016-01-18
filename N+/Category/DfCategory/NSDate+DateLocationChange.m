//
//  NSDate+DateLocationChange.m
//  N+
//
//  Created by hy1 on 16/1/13.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "NSDate+DateLocationChange.h"

@implementation NSDate (DateLocationChange)

+ (NSString *)NSDate2FormatNSString:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //设置本地格式
    [formatter setLocale:[NSLocale currentLocale]];
    //设置输出显示格式
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSString *str = [formatter stringFromDate:date];
    return str;
}

@end
