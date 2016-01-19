//
//  AAASearchTool.m
//  BaseProject
//
//  Created by hy1 on 16/1/11.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//


#define SearchListWeb @"http://120.76.77.155:8003/Server/GetQueryListResult?entname=%@&tbname=%@&empcode=%@"
#define FunctionButtonWeb @"http://120.76.77.155:8003/Server/GetModuleList?entname=%@&empcode=%@"
#define SearchDetailListWeb @"http://120.76.77.155:8003/Server/GetQueryDetailResult?entname=%@&tbname=%@&empcode=%@&autoid=%@"
#define IsRightSalaryPwd @"http://120.76.77.155:8003/Server/CheckSalaryPwd?entname=%@&empcode=%@&salarypwd=%@"

#import "AAASearchTool.h"
#import "AAASearchParam.h"
#import "NSString+CN2UTF8.h"

#import "PDDataResult.h"
#import "VContentResult.h"
#import "TableViewContentResult.h"
#import "TVCDataInfoResult.h"
#import "PDDataInfoResult.h"

@interface AAASearchTool ()

///返回查询列表接口
- (void)getTableViewContent:(AAASearchParam *)sp Success:(void(^)(TableViewContentResult *result))success Failure:(void(^)(NSError *error))failure;

@end


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

///返回查询列表接口
- (void)getTableViewContent:(AAASearchParam *)sp Success:(void (^)(TableViewContentResult *))success Failure:(void (^)(NSError *))failure{
    NSLog(@"%@",sp);
    NSString *url = [NSString stringWithFormat:SearchListWeb,[NSString CNToUTF8:sp.entname],[NSString CNToUTF8:sp.tbname],sp.empcode];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TableViewContentResult *result = [TableViewContentResult mj_objectWithKeyValues:responseObject[@"data"]];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


///返回查询界面功能按钮列表
- (void)getViewContent:(AAASearchParam *)sp Success:(void (^)(VContentResult *))success Failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:FunctionButtonWeb,[NSString CNToUTF8:@"百得电器"],@"111714"];
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


///返回查询数据明细接口1
- (void)getPresentDailyData:(AAASearchParam *)sp Success:(void (^)(NSArray *, NSArray *))success Failure:(void (^)(NSError *))failure{
    
    [self getTableViewContent:sp Success:^(TableViewContentResult *result) {
        NSArray *arr1 = result.datainfo;
        
        NSString *url = [NSString stringWithFormat:SearchDetailListWeb,[NSString CNToUTF8:sp.entname],[NSString CNToUTF8:sp.tbname],sp.empcode,sp.autoid];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            PDDataResult *result = [PDDataResult mj_objectWithKeyValues:responseObject[@"data"]];
            NSArray *arr2 = [[NSArray mj_objectArrayWithKeyValuesArray:result.datainfo] copy][0];
            
            NSMutableArray *firstArr = [NSMutableArray array];
            for (TVCDataInfoResult *tvc in arr1) {
                if (firstArr.count == 0) {
                    [firstArr addObject:tvc.GroupName];
                }else{
                    if (![firstArr containsObject:tvc.GroupName]) {
                        [firstArr addObject:tvc.GroupName];
                    }
                }
            }
            
            NSMutableArray *secondArr = [NSMutableArray array];
            for (NSString *str in firstArr) {
                NSMutableArray *keyArr = [NSMutableArray array];
                NSMutableArray *valueArr = [NSMutableArray array];
                for (TVCDataInfoResult *tvc in arr1) {
                    for (PDDataInfoResult *pd in arr2) {
                        if ([tvc.FieldName isEqualToString:pd.FieldName]&&[tvc.GroupName isEqualToString:str]) {
                            [keyArr addObject:pd.FieldName];
                            [valueArr addObject:pd.FieldValue];
                        }
                    }
                }
                [secondArr addObject:keyArr];
                [secondArr addObject:valueArr];
            }
            
            success([firstArr copy],[secondArr copy]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    } Failure:^(NSError *error) {
        failure(error);;
    }];
}

///返回查询数据明细接口2
- (void)getPresentDailyDataMore:(AAASearchParam *)sp Success:(void (^)(NSArray *, NSArray *))success Failure:(void (^)(NSError *))failure{
    NSString *firstArr = nil;
        
        NSString *url = [NSString stringWithFormat:SearchDetailListWeb,[NSString CNToUTF8:sp.entname],[NSString CNToUTF8:sp.tbname],sp.empcode,sp.autoid];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            PDDataResult *result = [PDDataResult mj_objectWithKeyValues:responseObject[@"data"]];
            NSArray *arr = [[NSArray mj_objectArrayWithKeyValuesArray:result.datainfo] copy];
            
            NSMutableArray *secondArr = [NSMutableArray array];
            for (NSArray *arr1 in arr) {
                NSMutableArray *arr2 = [NSMutableArray array];
                for (PDDataInfoResult *result in arr1) {
                    [arr2 addObject:result.FieldValue];
                }
                [secondArr addObject:arr2];
            }
            
        success([firstArr copy],[secondArr copy]);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
   
}



///验证用户工资密码是否正确接口
- (void)salaryPwdIsRight:(NSString *)password Success:(void (^)(BOOL))success Failure:(void (^)(NSError *))failure{
     NSString *url = [NSString stringWithFormat:IsRightSalaryPwd,[NSString CNToUTF8:@"百得电器"],@"111714",password];
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
