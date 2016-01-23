//
//  AAALoginResult.m
//  N+
//
//  Created by hy1 on 16/1/21.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAALoginResult.h"

@implementation AAALoginResult

static AAALoginResult *lp = nil;
+ (void)initialize{
    if (self == [self class]) {
        lp = [[self alloc] init];
    }
}
+ (instancetype)sharedAAALoginResult{
    return lp;
}

@end
