//
//  AAATabBarController.m
//  N+
//
//  Created by hy2 on 16/1/22.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAATabBarController.h"

#import "AAAHomeViewController.h"
#import "AAACheckViewController.h"
//新版
//#import "AAAHouseBaseViewController.h"
#import "AAAHouseTableViewController.h"
#import "AAASettingViewController.h"


@interface AAATabBarController ()

@end

@implementation AAATabBarController
- (UITabBarController *)tabBarController
{
    if (!_tabBarController) {
        _tabBarController = [[UITabBarController alloc] init];
    }return _tabBarController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *firstStory = [UIStoryboard storyboardWithName:@"lala" bundle:nil];
    UIViewController *firstController = [firstStory instantiateViewControllerWithIdentifier:@"house"];
    UIViewController *firstNaviController = [[UINavigationController alloc] initWithRootViewController:firstController];
    firstNaviController.title = @"管家";
    firstNaviController.tabBarItem.image = [UIImage imageNamed:@"first_selected"];
   
    UIStoryboard *checkStory = [UIStoryboard storyboardWithName:@"check" bundle:nil];
    UIViewController *checkController = [checkStory instantiateViewControllerWithIdentifier:@"check"];
    UINavigationController *checkNaviController = [[UINavigationController alloc] initWithRootViewController:checkController];
    checkNaviController.title = @"返回";
    checkNaviController.tabBarItem.image = [UIImage imageNamed:@"second_selected"];
    
    UIStoryboard *houseStory = [UIStoryboard storyboardWithName:@"first" bundle:nil];
    UIViewController *houseController = [houseStory instantiateViewControllerWithIdentifier:@"first"];
    UIViewController *houseNaviController = [[UINavigationController alloc] initWithRootViewController:houseController];
    houseNaviController.title   = @"公司动态";
    houseNaviController.tabBarItem.image = [UIImage imageNamed:@"third_selected"];
    
    UIStoryboard *settingStory = [UIStoryboard storyboardWithName:@"setting" bundle:nil];
    UIViewController *settingController = [settingStory instantiateViewControllerWithIdentifier:@"settingStory"];
    UIViewController *settingNaviController = [[UINavigationController alloc] initWithRootViewController:settingController];
    settingNaviController.title = @"设置";
    settingNaviController.tabBarItem.image = [UIImage imageNamed:@"forth_selected"];
    
    [self setViewControllers:@[firstNaviController,checkNaviController,houseNaviController,settingNaviController]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
