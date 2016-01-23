//
//  AAALoginParam.m
//  BaseProject
//
//  Created by hy1 on 16/1/8.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAALoginParam.h"

@interface AAALoginParam ()

@end

@implementation AAALoginParam

static AAALoginParam *lp = nil;
+ (void)initialize{
    if (self == [self class]) {
        lp = [[self alloc] init];
    }
}
+ (instancetype)sharedAAALoginParam{
    return lp;
}

@end
