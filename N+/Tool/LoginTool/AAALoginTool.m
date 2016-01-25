//
//  AAALoginTool.m
//  BaseProject
//
//  Created by hy1 on 16/1/7.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAALoginTool.h"
#import "AAALoginParam.h"
#import "AAALoginResult.h"
#import "AAARquestAPI.h"

@implementation AAALoginTool
<<<<<<< HEAD
#pragma mark - 1)注册接口
/*
 参数： entname - 公司名称，empcode - 工号，pwd - 登陆密码，telephone - 电话号码
=======

/*
1)注册接口
 参数： entname - 公司名称，empcode - 工号，pwd - 登陆密码，telephone - 电话号码
 
>>>>>>> origin/HYDeFeng
 返回值1：
 {
 “flag”:”True”,
 “info”:”提示信息”,
 “userid”:”34223432”
 }
<<<<<<< HEAD
=======
 
>>>>>>> origin/HYDeFeng
 返回值2：
 {
 “flag”:"False",
 “info”:”提示信息”,
 “userid”:””
 }
<<<<<<< HEAD
=======
 
>>>>>>> origin/HYDeFeng
 返回信息说明：
 Flag: 注册是否成功的标记，True表示成功，False表示失败;
 Info: 如果注册失败，返回失败的提示信息；
 userid: 如果注册成功，返回云服务中表tsys_clounduser 的userid值。
*/

+ (void)registerInWeb:(AAALoginParam *)lp Success:(void (^)(NSString *))success Failure:(void (^)(NSError *))failure{
    //拼接请求url
    NSString *url = [NSString stringWithFormat:aRegionWeb,lp.corporationName,lp.staffNummber,lp.password,lp.telephone];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        success(responseObject[@"userid"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
<<<<<<< HEAD
#pragma mark - 2)登录接口
=======

>>>>>>> origin/HYDeFeng
/*
 2)登录接口
 http://120.76.77.155:8003/Server/Login?userid=18&pwd=123456
 http://120.76.77.155:8003/Server/Login?userid=16&pwd=120944
 
 参数： userid - 云账号id，pwd - 云账号密码
 
 返回值：{"flag":"True"} / {"flag":"False"}
 
 返回信息说明：
 Flag 为登录成功的标记，True表示登录成功， False表示失败;
 */
+ (void)loginInWeb:(AAALoginParam *)lp Success:(void (^)(BOOL))success Failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:aLoginInServer,lp.userNameInWeb,lp.userPasswordInWeb];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        BOOL result = [responseObject[@"flag"] isEqualToString:@"True"];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
<<<<<<< HEAD
#pragma mark -3)获取HR工号接口
=======

>>>>>>> origin/HYDeFeng
/*
3)获取HR工号接口

接口示例

http://120.76.77.155:8003/Server/GetEmpCode?entname=百得电器&userid=17
http://120.76.77.155:8003/Server/GetEmpCode?entname=华跃科技&userid=18

参数： entname - 公司名称，userid - 云账号id

返回值：{"empcode":"201204230008"} / {"empcode":""}

返回信息说明：
Empcode 为返回的工号值，如果返回空，则表示该用户没有绑定企业或已经离职；
 */
+ (void)stateOfStaff:(AAALoginParam *)lp Success:(void (^)(AAALoginResult *))success Failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:aLoginHREmpCodeInterface,lp.corporationName,lp.userNameInWeb];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        AAALoginResult *result = [AAALoginResult mj_objectWithKeyValues:responseObject];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
<<<<<<< HEAD
#pragma mark -5)修改用户工资密码接口
/*
 http://120.76.77.155:8003/Server.asmx/UpdateSalaryPwd?entname=华跃科技&empcode=201204230011&oldpwd=123456&newpwd=123
 
 http://120.76.77.155:8003/Server.asmx/UpdateSalaryPwd?entname=百得电器&empcode=111714&oldpwd=123456&newpwd=123
 参数： entname - 公司名称，empcode - 工号，oldpwd - 旧工资密码，newpwd - 新工资密码
=======

/*
 5)修改用户工资密码接口
 
 接口示例
 
 http://120.76.77.155:8003/Server.asmx/UpdateSalaryPwd?entname=华跃科技&empcode=201204230011&oldpwd=123456&newpwd=123
 
 http://120.76.77.155:8003/Server.asmx/UpdateSalaryPwd?entname=百得电器&empcode=111714&oldpwd=123456&newpwd=123
 
 参数： entname - 公司名称，empcode - 工号，oldpwd - 旧工资密码，newpwd - 新工资密码
 
>>>>>>> origin/HYDeFeng
 返回值： {"result":true} / {"result":false}
 
 值说明：true - 修改成功
 false - 修改失败
 */
+ (void)alertLoginPassword:(AAALoginParam *)lp Success:(void (^)(BOOL))success Failure:(void (^)(NSError *))failure
{
    NSString *url = [NSString stringWithFormat:aHouseWebUpdateLoginPwd,lp.corporationName,lp.staffNummber,lp.password,lp.nnewLoginPassword];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        BOOL result = (BOOL)responseObject[@"result"];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}
<<<<<<< HEAD
#pragma mark - 6 非企业员工注册
/*http://url/reguser?entname=@entname&empcode=@empcode&pwd=@pwd&telephone=@telephone&isent=@isent
 @entname：企业名称
 @empcode：工号
 @pwd：登录密码（也是HR查询密码）
 @telephone：手机号
 @isent：是否企业用户注册，1：是，0：否
 返回信息：
 {
 “flag”:”True”,
 “info”:”提示信息”,
 “userid”:”34223432”
 }
 返回信息说明：
 Flag: 注册是否成功的标记，True表示成功，False表示失败;
 Info: 如果注册失败，返回失败的提示信息；
 userid: 如果注册成功，返回云服务中表tsys_clounduser 的userid值；
 
 接口内部处理逻辑：
 {
 String entver=getver; //获取企业的版本号
 Int  userid;
 
 //调用HR服务的接口 (主要是判断工号是否正确或者能否访问HR服务器)
 http://hrsvr/reguser?entname=@entname&ver=@ver
 &empcode=@empcode&pwd=@pwd&telephone=@telephone
 
 //HR接口返回的信息是：flag , info , empid, empname
 //如果工号有误或HR网络不通，则 flag=false;
 
 If (flag==true)or(isent==true)
 {
 //调用云服务上的存储过程来增加用户
 Exec psys_reguser @entname,@emid,@empname,@pwd,@telephone,@isent
 //过程有一个返回值，用来返回  flag , userid , info 值；
 }
 
 //返回：flag , info , userid 
 }
*/


#pragma mark -登陆记录/退出登陆
=======



>>>>>>> origin/HYDeFeng
/*
 3)插入用户登录记录接口(登录正确后，调用)
 
 接口示例
 
 http://120.76.77.155:8003/Server.asmx/InsertLoginLog?entname=公司名称1&empcode=201204230011&phonetype=iphone&addr=登陆地址
 
 http://120.76.77.155:8003/Server.asmx/InsertLoginLog?entname=公司名称2&empcode=111714&phonetype=android&addr=登陆地址
 
 参数： entname - 公司名称，empcode - 工号， phonetype - 手机类型，addr - 登陆地址
 
 返回值： {"result":true} / {"result":false}
 
 值说明：true - 插入成功
 false - 插入失败
 
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
 
 
 4)用户退出登录时调用的接口(记录退出时间，以及计算登陆时间)
 
 http://120.76.77.155:8003/Server.asmx/UpdateLoginLog?entname=华跃科技&empcode=201204230011
 
 http://120.76.77.155:8003/Server.asmx/UpdateLoginLog?entname=百得电器&empcode=111714
 
 参数： entname - 公司名称，empcode - 工号
 
 返回值： {"result":true} / {"result":false}
 
 值说明：true - 更新成功
 false - 更新失败
 
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
 */


@end
