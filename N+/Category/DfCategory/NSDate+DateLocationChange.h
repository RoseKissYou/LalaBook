//
//  NSDate+DateLocationChange.h
//  N+
//
//  Created by hy1 on 16/1/13.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//  NSDate转换成本地时间，再转成特定格式NSString

#import <Foundation/Foundation.h>

@interface NSDate (DateLocationChange)
///按日查询->返回yyyy/MM/dd
+ (NSString *)NSDate2FormatNSString:(NSDate *)date;
///按月查询->返回yyyyMM
+ (NSString *)NSDate2FormatNSStringByMonth:(NSDate *)date;
///按年查询->返回yyyy年
+ (NSString *)NSDate2FormatNSStringByYear:(NSDate *)date;

///日历用 ->返回yyyy
+ (NSString *)NSDate2StrByYear:(NSDate *)date;
///日历用 ->返回MM月
+ (NSString *)NSDate2StrByMonth:(NSDate *)date;
@end
