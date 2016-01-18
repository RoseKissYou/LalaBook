//
//  NSDictionary+In2ArrayOutDic.m
//  N+
//
//  Created by hy1 on 16/1/13.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "NSDictionary+In2ArrayOutDic.h"
//数组中模型引入
#import "PDDataInfoResult.h"
#import "TVCDataInfoResult.h"

@implementation NSDictionary (In2ArrayOutDic)

+ (NSDictionary *)In2ArrayOutDicWithOneArr:(NSArray *)oneArr andTwoArr:(NSArray *)twoArr{
    NSMutableArray *firstArr = [NSMutableArray array];
    for (TVCDataInfoResult *tvc in oneArr) {
        if (firstArr.count == 0) {
            [firstArr addObject:tvc.GroupName];
        }else{
            if (![firstArr containsObject:tvc.GroupName]) {
                [firstArr addObject:tvc.GroupName];
            }
        }
    }
    NSLog(@"%@",firstArr);
    
    NSMutableArray *secondArr = [NSMutableArray array];
    for (NSString *str in firstArr) {
        NSMutableArray *keyArr = [NSMutableArray array];
        NSMutableArray *valueArr = [NSMutableArray array];
        for (TVCDataInfoResult *tvc in oneArr) {
            for (PDDataInfoResult *pd in twoArr) {
                if ([tvc.FieldName isEqualToString:pd.FieldName]&&[tvc.GroupName isEqualToString:str]) {
                    [keyArr addObject:pd.FieldName];
                    [valueArr addObject:pd.FieldValue];
                }
            }
        }
        NSDictionary *dic = [[NSDictionary alloc]initWithObjects:valueArr forKeys:keyArr];
        [secondArr addObject:dic];
    }
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjects:[secondArr copy] forKeys:[firstArr copy]];
    return dic;
}

@end
