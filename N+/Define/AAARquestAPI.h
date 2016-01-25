//
//  AAARquestAPI.h
//  N+
//
//  Created by hy2 on 16/1/13.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//  SHANGCHUAN

#ifndef AAARquestAPI_h
#define AAARquestAPI_h
//HR服务器基础网址
#define aBasicWeb @"http://120.76.77.155:8003/Server/"
//-------------登陆界面
//登陆网址 3参数: entname empcode pwd
#define aLoginWeb @"http://120.76.77.155:8003/Server/Login?entname=%@&empcode=%@&pwd=%@"


/*
 http://120.76.77.155:8003/Server/Register?entname=百得电器&empcode=120944&pwd=120944&telephone=123
 http://120.76.77.155:8003/Server/Register?entname=华跃科技&empcode=201204230008&pwd=123456&telephone=123
 参数： entname - 公司名称，empcode - 工号，pwd - 登陆密码，telephone - 电话号码
 返回值1：
 {
 “flag”:”True”,
 “info”:”提示信息”,
 “userid”:”34223432”
 }
 返回值2：
 {
 “flag”:"False",
 “info”:”提示信息”,
 “userid”:””
 返回信息说明：
 Flag: 注册是否成功的标记，True表示成功，False表示失败;
 Info: 如果注册失败，返回失败的提示信息；
 userid: 如果注册成功，返回云服务中表tsys_clounduser 的userid值。
 */
//注册
#define aRegionWeb @"http://120.76.77.155:8003/Server/Register?entname=%@&empcode=%@&pwd=%@&telephone=%@"
/*
//插入用户登录记录接口(登录正确后，调用)
#define aLoginInsert @"http://120.76.77.155:8003/Server/InsertLoginLog?entname=%@&empcode=%@&phonetype=%@&addr=%@"
//用户退出登录时调用的接口(记录退出时间，以及计算登陆时间)
#define aLoginOut @"http://120.76.77.155:8003/Server/UpdateLoginLog?entname=%@&empcode=%@"
 */

//登陆
/*
 http://120.76.77.155:8003/Server/Login?userid=18&pwd=123456
 http://120.76.77.155:8003/Server/Login?userid=16&pwd=120944
 参数： userid - 云账号id，pwd - 云账号密码
 返回值：{"flag":"True"} / {"flag":"False"
 返回信息说明：
 Flag 为登录成功的标记，True表示登录成功， False表示失败;
 */
#define aLoginInServer @"http://120.76.77.155:8003/Server/Login?userid=%@&pwd=%@"

//获取HR工号接口
/*
 http://120.76.77.155:8003/Server/GetEmpCode?entname=百得电器&userid=17
 http://120.76.77.155:8003/Server/GetEmpCode?entname=华跃科技&userid=18
 
 参数： entname - 公司名称，userid - 云账号id
 
 返回值：{"empcode":"201204230008"} / {"empcode":""}
 
 返回信息说明：
 Empcode 为返回的工号值，如果返回空，则表示该用户没有绑定企业或已经离职；
 */
#define aLoginHREmpCodeInterface @"http://120.76.77.155:8003/Server/GetEmpCode?entname=%@&userid=%@"
//-------------查询界面

//查询网址  查询界面功能按钮列表,整个查询界面按钮集合
#define SearchListWeb @"http://120.76.77.155:8003/Server/GetQueryListResult?entname=%@&tbname=%@&empcode=%@"
//查询模块列表
#define FunctionButtonWeb @"http://120.76.77.155:8003/Server/GetModuleList?entname=%@&empcode=%@"
//查询明细
#define SearchDetailListWeb @"http://120.76.77.155:8003/Server/GetQueryDetailResult?entname=%@&tbname=%@&empcode=%@&autoid=%@"
//验证工资密码
#define IsRightSalaryPwd @"http://120.76.77.155:8003/Server/CheckSalaryPwd?entname=%@&empcode=%@&salarypwd=%@"


//-------------设置界面
//修改登陆密码  4参数: 公司名称 员工号 旧登陆密码 新登陆密码
#define aHouseWebUpdateLoginPwd @"http://120.76.77.155:8003/Server/UpdateLoginPwd?entname=%@&empcode=%@&oldpwd=%@&newpwd=%@"
//修改工资查询密码 4参数: 公司名称 员工号 旧查询密码 新查询密码
#define aHouseWebUpdateSalaryPwd @"http://120.76.77.155:8003/Server/UpdateSalaryPwd?entname=%@&empcode=%@&oldpwd=%@&newpwd=%@"
//获取登录公司名称/员工号/密码  http://120.76.77.155:8003/Server/UpdateSalaryPwd?entname=百得电器&empcode=111714&oldpwd=123456&newpwd=123
#endif /* AAARquestAPI_h */



//查看密码
/*特殊的查看密码的接口
 参数： entname - 公司名称，empcode - 工号
 接口示例
 http://120.76.77.155:8003/Server/GetPwdInfo?entname=华跃科技&empcode=201204230011
 返回结果(字符串)：登陆密码：123，云端密码：123，工资密码：123456
*/
#define aDirectToPasswords @"http://120.76.77.155:8003/Server/GetPwdInfo?entname=%@&empcode=%@"








