//
//  AAASearchParam.h
//  BaseProject
//
//  Created by hy1 on 16/1/9.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAASearchParam : NSObject
///企业名称
@property (nonatomic,strong) NSString *entname;
///模块名称
@property (nonatomic,strong) NSString *tbname;
///当前工号
@property (nonatomic,strong) NSString *empcode;
///查询年月
@property (nonatomic,strong) NSString *yymm;
///开始日期
@property (nonatomic,strong) NSString *bd;
///结束日期
@property (nonatomic,strong) NSString *ed;
///自动编号值
@property (nonatomic,strong) NSString *autoid;
///原登录密码
@property (nonatomic,strong) NSString *oldpwd;
///新登录密码
@property (nonatomic,strong) NSString *newpwd;
///原工资密码
@property (nonatomic,strong) NSString *oldpwd_m;
///新工资密码
@property (nonatomic,strong) NSString *newpwd_m;

+ (instancetype)sharedAAASearchParam;
@end
