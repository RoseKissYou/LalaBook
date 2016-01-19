//
//  AAASearchParam.m
//  BaseProject
//
//  Created by hy1 on 16/1/9.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAASearchParam.h"

@implementation AAASearchParam

static AAASearchParam *sp = nil;
+ (void)initialize{
    if (self == [self class]) {
        sp = [[self alloc] init];
    }
}
+ (instancetype)sharedAAASearchParam{
    return sp;
}

@end
