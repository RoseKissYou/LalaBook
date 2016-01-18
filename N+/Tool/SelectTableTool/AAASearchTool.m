//
//  AAASearchTool.m
//  BaseProject
//
//  Created by hy1 on 16/1/11.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAASearchTool.h"
#import "AAASearchParam.h"
#import "NSString+CN2UTF8.h"

#import "PDDataResult.h"
#import "VContentResult.h"
#import "TableViewContentResult.h"

@implementation AAASearchTool
static AAASearchTool *st= nil;

+ (void)initialize{
    if (self == [self class]) {
        st = [[self alloc] init];
    }
}

+ (instancetype)sharedAAASearchTool{
    return st;
}


///返回查询界面功能按钮列表
- (void)getViewContent:(AAASearchParam *)sp Success:(void (^)(VContentResult *))success Failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"http://120.76.77.155:8003/Server/GetModuleList?entname=%@&empcode=%@",[NSString CNToUTF8:@"百得电器"],@"111714"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#warning df-可以处理为返回参数模型
        VContentResult *result = [VContentResult mj_objectWithKeyValues:responseObject[@"data"]];
        success(result);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
   

}

///返回查询列表接口
- (void)getTableViewContent:(AAASearchParam *)sp Success:(void (^)(TableViewContentResult *))success Failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"http://120.76.77.155:8003/Server/GetQueryListResult?entname=%@&tbname=%@&empcode=%@",[NSString CNToUTF8:@"百得电器"],[NSString CNToUTF8:sp.tbname],@"111714"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
#warning df-转模型
        TableViewContentResult *result = [TableViewContentResult mj_objectWithKeyValues:responseObject[@"data"]];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

///返回查询数据明细接口
- (void)getPresentDailyData:(AAASearchParam *)sp Success:(void (^)(NSArray *))success Failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"http://120.76.77.155:8003/Server/GetQueryDetailResult?entname=%@&tbname=%@&empcode=%@&autoid=%@",[NSString CNToUTF8:@"百得电器"],[NSString CNToUTF8:@"日考勤查询"],@"111714",@"935004"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
#warning df-转模型
        PDDataResult *result = [PDDataResult mj_objectWithKeyValues:responseObject[@"data"]];
        NSArray *arr = [[NSArray mj_objectArrayWithKeyValuesArray:result.datainfo] copy];
        success(arr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

///点击日历上的时间，拿到当天的具体信息
/*http://120.76.77.155:8003//queryapi.ashx?
 entname=华跃&tbname=日考勤查询&list=1&empcode=0001&yymm=null
 &bd=2015/12/01&ed=2015/12/31
*/
- (void)getDataFormClickCalendar:(NSDate *)date Success:(void (^)())success Failure:(void (^)(NSError *))failure{
    NSLog(@"%@",date);
#warning df-日期格式转换
    NSString *url = [NSString stringWithFormat:@"http://120.76.77.155:8003/Server/GetQueryListResult?entname=%@&tbname=%@&empcode=%@&yymm=null&bd=%@&ed=%@",[NSString CNToUTF8:@"百得电器"],[NSString CNToUTF8:@"日考勤查询"],@"111714",@"935004"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
#warning df-转模型
        ;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

}


///验证用户工资密码是否正确接口
- (void)salaryPwdIsRight:(NSString *)password Success:(void (^)(BOOL))success Failure:(void (^)(NSError *))failure{
     NSString *url = [NSString stringWithFormat:@"http://120.76.77.155:8003/Server/CheckSalaryPwd?entname=%@&empcode=%@&salarypwd=%@",[NSString CNToUTF8:@"百得电器"],@"111714",password];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#warning df-返回中的真假需要先转成NSNumber，再取数值，最后转BOOL
        BOOL isRight = (BOOL)(((NSNumber *)responseObject[@"result"]).integerValue);
        success(isRight);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
