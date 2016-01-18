//
//  AAALoginTool.m
//  BaseProject
//
//  Created by hy1 on 16/1/7.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAALoginTool.h"
#import "AAALoginParam.h"


@implementation AAALoginTool

/*
1)登录接口

参数： entname - 公司名称，empcode - 工号，pwd - 密码

返回值： {"result":0} / {"result":1} / {"result":2}

值说明：0 - 登录错误
1 - 登录正确，且已注册
2 - 登录正确，未注册
*/

+ (void)loginUseTool:(AAALoginParam *)lp Success:(void (^)(NSInteger))success Failure:(void (^)(NSError *))failure{
    //拼接请求url
    NSString *url = [NSString stringWithFormat:aLoginWeb,lp.corporationName,lp.staffName,lp.password];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSNumber *result = (NSNumber *)responseObject[@"result"];
        success(result.integerValue);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 2)用户注册到云服务器接口(登录正确，未注册 时，调用)
 
 接口示例
 
 http://120.76.77.155:8003/Server.asmx/UserRegister?entname=公司名称1&empcode=201204230011&telephone=123
 
 http://120.76.77.155:8003/Server.asmx/UserRegister?entname=公司名称2&empcode=111714&telephone=123
 
 
 参数： entname - 公司名称，empcode - 工号，telephone - 电话号码
 
 返回值： {"result":true} / {"result":false}
 
 值说明：true - 注册成功
 false - 注册失败
 */

+ (void)registerTelephone:(AAALoginParam *)lp Success:(void (^)(BOOL))success Failure:(void (^)(NSError *))failure{
    //拼接请求url
    NSString *url = [NSString stringWithFormat:aRegionWeb,lp.corporationName,lp.staffName,lp.telephone];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        BOOL result = (BOOL)responseObject[@"result"];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 3)插入用户登录记录接口(登录正确后，调用)
 
 接口示例
 
 http://120.76.77.155:8003/Server.asmx/InsertLoginLog?entname=公司名称1&empcode=201204230011&phonetype=iphone&addr=登陆地址
 
 http://120.76.77.155:8003/Server.asmx/InsertLoginLog?entname=公司名称2&empcode=111714&phonetype=android&addr=登陆地址
 
 参数： entname - 公司名称，empcode - 工号， phonetype - 手机类型，addr - 登陆地址
 
 返回值： {"result":true} / {"result":false}
 
 值说明：true - 插入成功
 false - 插入失败
 */
+ (void)uploadTelephoneTypeAndAddr:(AAALoginParam *)lp Success:(void (^)(BOOL))success Failure:(void (^)(NSError *))failure{
    //拼接请求url
    NSString *url = [NSString stringWithFormat:aLoginInsert,lp.corporationName,lp.staffName,lp.phoneType,lp.address];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        BOOL result = (BOOL)responseObject[@"result"];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

/*
 4)用户退出登录时调用的接口(记录退出时间，以及计算登陆时间)
 
 http://120.76.77.155:8003/Server.asmx/UpdateLoginLog?entname=华跃科技&empcode=201204230011
 
 http://120.76.77.155:8003/Server.asmx/UpdateLoginLog?entname=百得电器&empcode=111714
 
 参数： entname - 公司名称，empcode - 工号
 
 返回值： {"result":true} / {"result":false}
 
 值说明：true - 更新成功
 false - 更新失败
 */
+ (void)loginOut:(AAALoginParam *)lp Success:(void (^)(BOOL))success Failure:(void (^)(NSError *))failure{
    //拼接请求url
    NSString *url = [NSString stringWithFormat:aLoginOut,lp.corporationName,lp.staffName];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        BOOL result = (BOOL)responseObject[@"result"];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
/*
 5)修改用户工资密码接口
 
 接口示例
 
 http://120.76.77.155:8003/Server.asmx/UpdateSalaryPwd?entname=华跃科技&empcode=201204230011&oldpwd=123456&newpwd=123
 
 http://120.76.77.155:8003/Server.asmx/UpdateSalaryPwd?entname=百得电器&empcode=111714&oldpwd=123456&newpwd=123
 
 参数： entname - 公司名称，empcode - 工号，oldpwd - 旧工资密码，newpwd - 新工资密码
 
 返回值： {"result":true} / {"result":false}
 
 值说明：true - 修改成功
 false - 修改失败
 */
+ (void)alertLoginPassword:(AAALoginParam *)lp Success:(void (^)(BOOL))success Failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:aHouseWebUpdateLoginPwd,lp.corporationName,lp.staffName,lp.password,lp.nnewLoginPassword];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        BOOL result = (BOOL)responseObject[@"result"];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}



@end
