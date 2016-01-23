//
//  AAALoginTool.h
//  BaseProject
//
//  Created by hy1 on 16/1/7.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AAALoginParam;
@class AAALoginResult;
@interface AAALoginTool : NSObject

/**
 用户注册接口：流程说明
 1.从HR服务器中关联员工号和密码
 2.如若成功，把手机号插入到云端表格中；否则，注册失败
 */
+ (void)registerInWeb:(AAALoginParam *)lp Success:(void(^)(NSString *userid))success Failure:(void(^)(NSError *error))failure;

/**
 登录接口：流程说明
 直接根据云端的账号和密码登录到云端
 */
+ (void)loginInWeb:(AAALoginParam *)lp Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;

/**
 HR工号接口：流程说明
 登陆期间默认，访问HR服务器，判断员工的在职状况（在职和离职）
 */
+ (void)stateOfStaff:(AAALoginParam *)lp Success:(void(^)(AAALoginResult *result))success Failure:(void(^)(NSError *error))failure;


//修改用户登陆密码
+ (void)alertLoginPassword:(AAALoginParam *)lp Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;

/****************************暂时不用****************************/
/**
 插入用户登录记录接口(登录正确后，调用)
 */
//+ (void)uploadTelephoneTypeAndAddr:(AAALoginParam *)lp Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;
/**
 用户退出登录时调用的接口(记录退出时间，以及计算登陆时间)
 */
//+ (void)loginOut:(AAALoginParam *)lp Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;
@end
