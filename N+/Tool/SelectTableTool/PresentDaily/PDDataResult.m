//
//  PDDataResult.m
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "PDDataResult.h"
#import "PDDataInfoResult.h"

@implementation PDDataResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"datainfo":[PDDataInfoResult class]};
}

@end
