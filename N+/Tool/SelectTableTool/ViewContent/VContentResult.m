//
//  PDDataResult.m
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "VContentResult.h"
#import "VCDataInfoResult.h"

@implementation VContentResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"datainfo":[VCDataInfoResult class]};
}

@end
