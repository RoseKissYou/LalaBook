//
//  AAARquestAPI.h
//  N+
//
//  Created by hy2 on 16/1/13.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#ifndef AAARquestAPI_h
#define AAARquestAPI_h
//HR服务器基础网址
#define aBasicWeb @"http://120.76.77.155:8003/Server/"
//-------------登陆界面
//登陆网址 3参数: entname empcode pwd
#define aLoginWeb @"http://120.76.77.155:8003/Server/Login?entname=%@&empcode=%@&pwd=%@"
//注册
#define aRegionWeb @"http://120.76.77.155:8003/Server/UserRegister?entname=%@&empcode=%@&telephone=%@"
//插入用户登录记录接口(登录正确后，调用)
#define aLoginInsert @"http://120.76.77.155:8003/Server/InsertLoginLog?entname=%@&empcode=%@&phonetype=%@&addr=%@"
//用户退出登录时调用的接口(记录退出时间，以及计算登陆时间)
#define aLoginOut @"http://120.76.77.155:8003/Server/UpdateLoginLog?entname=%@&empcode=%@"



//-------------查询界面
//查询网址  查询界面功能按钮列表
#define aCheckWebGetModuleList @"http://120.76.77.155:8003/Server/GetModuleList?entname=%@&empcode=%@"
//查询数据明细接口
#define aCheckWebGetQueryDetailResult @"http://120.76.77.155:8003/Server/GetQueryDetailResult?entname=%@&tbname=%@&empcode=%@&autoid=%@"




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








