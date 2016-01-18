//
//  AAAHomeTab.m
//  BaseProject
//
//  Created by 小笨熊 on 16/1/5.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAAHomeTab.h"
@interface AAAHomeTab ()
@property (strong, nonatomic)  NSString *essayHeaderName;
@property (strong, nonatomic)  NSString *essayName;
@property (strong, nonatomic)  NSString *essayJob;
@property (strong, nonatomic)  NSString *essayTime;
@property (strong, nonatomic)  NSString *essayAdmine;
@property (strong, nonatomic)  NSString *essayComments;
@property (strong, nonatomic)  NSString *essayLocation;
@property (strong, nonatomic)  NSString *essayContents;
@property (strong, nonatomic)  NSString *essayContentImage;
@end
@implementation AAAHomeTab
+ (NSArray *)show
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 1; i < 13; i++) {
        AAAHomeTab *a1 = [[AAAHomeTab alloc]init];
        a1.essayHeaderName = [NSString stringWithFormat: @"截图%d",i ];
        a1.essayName = [NSString stringWithFormat:@"hy%d",i];
        a1.essayJob = @"研发部";
        
    }
    
    
    return array;
}

@end
