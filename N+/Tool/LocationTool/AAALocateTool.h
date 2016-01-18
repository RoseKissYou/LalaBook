//
//  AAALocateTool.h
//  BaseProject
//
//  Created by hy1 on 16/1/8.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AAALocateTool : NSObject

+ (instancetype)sharedAAALocateTool;
///获取位置名称
- (void)getLocation;
@end
