//
//  AAALoginTool.h
//  BaseProject
//
//  Created by hy1 on 16/1/7.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AAALoginParam;
@interface AAALoginTool : NSObject

/**
 登录接口
 */
+ (void)loginUseTool:(AAALoginParam *)lp Success:(void(^)(NSInteger result))success Failure:(void(^)(NSError *error))failure;
/**
 用户注册到云服务器接口(登录正确，未注册时，调用)
 */
+ (void)registerTelephone:(AAALoginParam *)lp Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;
/**
 插入用户登录记录接口(登录正确后，调用)
 */
+ (void)uploadTelephoneTypeAndAddr:(AAALoginParam *)lp Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;
/**
 用户退出登录时调用的接口(记录退出时间，以及计算登陆时间)
 */
+ (void)loginOut:(AAALoginParam *)lp Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;


//修改用户登陆密码
+ (void)alertLoginPassword:(AAALoginParam *)lp Success:(void(^)(BOOL result))success Failure:(void(^)(NSError *error))failure;
@end
