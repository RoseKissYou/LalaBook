//
//  AAALoginParam.h
//  BaseProject
//
//  Created by hy1 on 16/1/8.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAALoginParam : NSObject
/*********************注册参数*********************/
///公司名
@property (strong,nonatomic) NSString *corporationName;
///员工号
@property (strong,nonatomic) NSString *staffNummber;
///登陆密码
@property (strong,nonatomic) NSString *password;
///手机号码
@property (strong,nonatomic) NSString *telephone;

/*********************登录参数*********************/
//云端用户名
@property (strong, nonatomic) NSString *userNameInWeb;
//云端密码
@property (strong, nonatomic) NSString *userPasswordInWeb;

/*********************修改登录参数*********************/
//新登陆密码
@property (strong, nonatomic) NSString *nnewLoginPassword;

#warning df-iPhone
//手机类型
@property (strong,nonatomic) NSString *phoneType;
//地址
@property (strong,nonatomic) NSString *address;

+ (instancetype)sharedAAALoginParam;

@end
