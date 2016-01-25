//
//  AAASettingNavigationController.m
//  N+
//
//  Created by hy2 on 16/1/22.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAASettingNavigationController.h"
#import "AAASettingViewController.h"
@interface AAASettingNavigationController ()

@end

@implementation AAASettingNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIStoryboard *settingStory = [UIStoryboard storyboardWithName:@"setting" bundle:nil];
    AAASettingViewController *settingCon = [settingStory instantiateViewControllerWithIdentifier:@"settingStory"];
    [self.navigationController pushViewController:settingCon animated:YES];
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
