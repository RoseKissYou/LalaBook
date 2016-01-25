//
//  AAASettingViewController.m
//  BaseProject
//
//  Created by hy1 on 16/1/8.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAASettingViewController.h"
#import "AAALoginTool.h"
#import "AAALoginParam.h"
//用户信息单例
#import "AAASearchParam.h"

@interface AAASettingViewController ()
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

//用户电话
@property (weak, nonatomic) IBOutlet UILabel *userNameNumber;
@end

@implementation AAASettingViewController


- (IBAction)outToLogin:(UIButton *)sender {
//    [AAALoginTool loginOut:[AAALoginParam sharedAAALoginParam] Success:^(BOOL result) {
//        if (result) {
//            NSLog(@"更新成功");
//        }else{
//            NSLog(@"更新失败");
//        }
//        exit(0);
//    } Failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
