//
//  AAASearchTool.h
//  BaseProject
//
//  Created by hy1 on 16/1/11.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AAASearchParam;
@class VContentResult;
@class PDDataResult;
@class TableViewContentResult;

@interface AAASearchTool : NSObject

+ (instancetype)sharedAAASearchTool;

///返回查询界面功能按钮列表
- (void)getViewContent:(AAASearchParam *)sp Success:(void(^)(VContentResult *result))success Failure:(void(^)(NSError *error))failure;

///返回查询列表接口
- (void)getTableViewContent:(AAASearchParam *)sp Success:(void(^)(TableViewContentResult *result))success Failure:(void(^)(NSError *error))failure;

///返回查询数据明细接口
- (void)getPresentDailyData:(AAASearchParam *)sp Success:(void(^)(NSArray *result))success Failure:(void(^)(NSError *error))failure;

///点击日历上的时间，拿到当天的具体信息
- (void)getDataFormClickCalendar:(NSDate *)date Success:(void(^)())success Failure:(void(^)(NSError *error))failure;

///验证用户工资密码是否正确接口
- (void)salaryPwdIsRight:(NSString *)password Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;
@end
