//
//  AAANewLoginViewController.m
//  N+
//
//  Created by hy2 on 16/1/18.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAANewLoginViewController.h"

#import "AAALoginTool.h"
#import "AAALoginParam.h"

#import "AAAHomeViewController.h"

#import "AAALocationStr.h"

@interface AAANewLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextFiled;

@end

@implementation AAANewLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)backToChoose:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginToApplication:(UIButton *)sender {
    AAALoginParam *param = [AAALoginParam sharedAAALoginParam];
    //这里把用户名和密码存在单例里面,
    
    if (self.userNameTextFiled.text == nil || self.userPasswordTextFiled.text == nil) {
        //提示密码不能为空
        [[[UIAlertView alloc]initWithTitle:@"输入错误" message:@"用户名或者密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil]  show];
    }else {
        param.corporationName =[@"百得电器" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        param.staffName = @"121075";
        param.password = @"121075";
        [AAALoginTool loginUseTool:param Success:^(NSInteger result) {
            //跳转到APP
            [self go2Main];
        } Failure:^(NSError *error) {
            
        }];
    }
    
}
- (void)go2Main{
    
    //把记录写入云
    //获取设备型号和地址
    AAALoginParam *param = [AAALoginParam sharedAAALoginParam];
    param.phoneType = [UIDevice currentDevice].model;
#warning df-写好定位方法
    param.address = [AAALocationStr sharedAAALocationStr].locationStr;
    [AAALoginTool uploadTelephoneTypeAndAddr:param Success:^(BOOL result) {
        NSLog(@"插入成功");
    } Failure:^(NSError *error) {
        NSLog(@"插入失败");
    }];
    
    //再跳转
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AAAHomeViewController *firstControl = [mainStory instantiateViewControllerWithIdentifier:@"Main"];
    [self presentViewController:firstControl animated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
