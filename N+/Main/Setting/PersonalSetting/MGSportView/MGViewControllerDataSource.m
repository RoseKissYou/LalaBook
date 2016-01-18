//
//  MGViewControllerDataSource.m
//  MGSpotyView
//
//  Created by Daniele Bogo on 08/08/2015.
//  Copyright (c) 2015 Matteo Gobbi. All rights reserved.
//

#import "MGViewControllerDataSource.h"
#import "MGSpotyViewController.h"


@implementation MGViewControllerDataSource


#pragma mark - MGSpotyViewControllerDataSource
- (NSInteger)numberOfSectionsInSpotyViewController:(MGSpotyViewController *)spotyViewController
{
    return 2;
}
//设置行数

- (NSInteger)spotyViewController:(MGSpotyViewController *)spotyViewController
           numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
//设置每行显示的内容
- (UITableViewCell *)spotyViewController:(MGSpotyViewController *)spotyViewController
                   cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellID";
    UITableViewCell *cell = [spotyViewController.tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        UIView *stroke = [[UIView alloc] init];
        stroke.backgroundColor = [UIColor grayColor];
        stroke.translatesAutoresizingMaskIntoConstraints = NO;
        [cell.contentView addSubview:stroke];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(stroke);
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[stroke(1)]|" options:0 metrics:nil views:views]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[stroke]|" options:0 metrics:nil views:views]];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"个人设置";
            cell.imageView.image = [UIImage imageNamed:@"mySetting"];
        }break;
            break;
            case 1:
        {
            cell.textLabel.text = @"消息中心";
            cell.imageView.image = [UIImage imageNamed:@"myMessage"];
        }break;
            case 2:
        {
            cell.textLabel.text = @"我的名片";
            cell.imageView.image = [UIImage imageNamed:@"myCard"];
        }break;
            case 3:
        {
            cell.textLabel.text = @"我的收藏";
            cell.imageView.image = [UIImage imageNamed:@"myCollection"];
        }break;
            case 5:
        {
            
        }
        default:
            break;
    }
   // cell.textLabel.text = @"你好";
    
    return cell;
}

@end
