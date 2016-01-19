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

///返回查询数据明细接口1
- (void)getPresentDailyData:(AAASearchParam *)sp Success:(void(^)(NSArray *result1,NSArray *result2))success Failure:(void(^)(NSError *error))failure;

///返回查询数据明细接口2
- (void)getPresentDailyDataMore:(AAASearchParam *)sp Success:(void(^)(NSArray *result1,NSArray *result2))success Failure:(void(^)(NSError *error))failure;

///验证用户工资密码是否正确接口
- (void)salaryPwdIsRight:(NSString *)password Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;


@end
