//
//  MGViewControllerDelegate.m
//  MGSpotyView
//
//  Created by Daniele Bogo on 08/08/2015.
//  Copyright (c) 2015 Matteo Gobbi. All rights reserved.
//

#import "MGViewControllerDelegate.h"
#import "MGSpotyViewController.h"


@implementation MGViewControllerDelegate


#pragma mark - MGSpotyViewControllerDelegate
//cell行高
- (CGFloat)spotyViewController:(MGSpotyViewController *)spotyViewController
       heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
//section高度
- (CGFloat)spotyViewController:(MGSpotyViewController *)spotyViewController
      heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}
//section设置
- (NSString *)spotyViewController:(MGSpotyViewController *)spotyViewController
          titleForHeaderInSection:(NSInteger)section
{
    return @"个人设置";
}


@end