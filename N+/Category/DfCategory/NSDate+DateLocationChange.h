//
//  NSDate+DateLocationChange.h
//  N+
//
//  Created by hy1 on 16/1/13.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//  NSDate转换成本地时间，再转成特定格式NSString

#import <Foundation/Foundation.h>

@interface NSDate (DateLocationChange)

+ (NSString *)NSDate2FormatNSString:(NSDate *)date;

@end
