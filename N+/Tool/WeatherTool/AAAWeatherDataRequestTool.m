//
//  AAAWeatherDataRequestTool.m
//  BaseProject
//
//  Created by hy1 on 16/1/7.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

/**
 *  openID:JH6096caaeacc0fe40b7b080028fc82185
 *  appKey:
 */

#import "AAAWeatherDataRequestTool.h"
//请求天气头文件
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"


#import "AAAWeather.h"


@implementation AAAWeatherDataRequestTool

static AAAWeatherDataRequestTool *wdrt = nil;
+ (void)initialize{
    if (self == [self class]) {
        wdrt = [[self alloc] init];
    }
}
+ (instancetype)sharedAAAWeatherDataRequestTool{
    return wdrt;
}


/**
 @brief  执行聚合数据请求, 操作请求返回的数据
 @param api           聚合数据服务接口，可以在聚合数据官网的数据接口API，接口地址中找到，如IP地址API接口：http://apis.juhe.cn/ip/ip2addr
 @param api_id        聚合数据服务接口，可以在聚合数据官网的数据接口API，URL地址中找到，如IP地址URL：http://www.juhe.cn/docs/api/id/1，则api_id:1
 @param paras         对应于服务类型的一些参数, 是Objective-C的NSDictionary类型，可以在IP地址API接口中“请求参数”
 @param success       请求得到处理, 并且返回有效数据时, 对返回的数据, 在主线程, 执行自定义的行为
 @param failure       没有网络, 或者服务器没有响应, 或者服务器没有返回有效数据, 对返回的NSError对象, 在主线程, 执行自定义的行为
 @discuss
 a. 数据服务类型的选择, 对应可用的HTTP请求方法, 对应可用的请求参数, 执行请求返回的Objective-C对象, 请参考SDK文档
 b. 执行数据请求是异步的, 开发者直接调用即可.
 */
- (void)requestWeatherDataWithcityName:(NSString *)cityName Success:(void (^)(AAAWeather *))success Failure:(void (^)(NSError *))failure{
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH6096caaeacc0fe40b7b080028fc82185"];
    //请求天气数据
    NSString *path = @"http://v.juhe.cn/weather/index";
    NSString *api_id = @"39";
    NSString *method = @"GET";
    NSDictionary *param = @{@"cityname":cityName, @"key":@"f5db9a975ff274694babef6c59987c34"};
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    
    [juheapi executeWorkWithAPI:path
                          APIID:api_id
                     Parameters:param
                         Method:method
                        Success:^(id responseObject){
                            NSLog(@"%@",responseObject);
                            if ([[param objectForKey:@"dtype"] isEqualToString:@"xml"]) {
                                NSLog(@"***xml*** \n %@", responseObject);
                            }else{
                                int error_code = [[responseObject objectForKey:@"error_code"] intValue];
                                if (!error_code) {//这里已经返回了数据
                                    NSLog(@"sk %@", responseObject[@"result"][@"sk"]);
                                    NSLog(@"today %@", responseObject[@"result"][@"today"]);
                                    /**
                                     *  处理数据
                                     */
                                    AAAWeather *weather = [AAAWeather mj_objectWithKeyValues:responseObject[@"result"]];
                                    NSLog(@"%@,%@",weather.sk,weather.today);
                                    success(weather);
                                }else{
                                    NSLog(@"b %@", responseObject);
                                }
                            }
                        } Failure:^(NSError *error) {
                            failure(error);
                        }];
}

@end
