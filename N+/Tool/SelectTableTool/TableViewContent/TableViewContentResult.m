//
//  PDDataResult.m
//  N+
//
//  Created by hy1 on 16/1/12.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "TableViewContentResult.h"
#import "TVCDataInfoResult.h"

@implementation TableViewContentResult

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"datainfo":[TVCDataInfoResult class]};
}

@end
