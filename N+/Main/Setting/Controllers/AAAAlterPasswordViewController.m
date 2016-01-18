//
//  AAAAlterPasswordViewController.m
//  N+
//
//  Created by 小笨熊 on 16/1/13.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//
#import "AAASearchParam.h"
#import "AAAAlterPasswordViewController.h"
//访问登陆单例获取公司名称/员工号/密码
#import "AAALoginTool.h"
#import "AAALoginParam.h"
@interface AAAAlterPasswordViewController ()

//修改登录密码
@property (weak, nonatomic) IBOutlet UITextField *originalLoginPassword;
@property (weak, nonatomic) IBOutlet UITextField *nnewLoginPassword;
@property (weak, nonatomic) IBOutlet UITextField *repeatNewPassword;



/**
 *  修改密码视图
 */
@property (weak, nonatomic) IBOutlet UIView *loginView;
//判断是修改登录密码还是查询密码
@property (assign, nonatomic) NSInteger LoginOrCheck;
//输入框地图约束

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomOfPassword;

@end

@implementation AAAAlterPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化修改登录密码界面
    self.loginView.hidden = YES;
    //监听键盘弹起
    
    
    // Do any additional setup after loading the view.
}
//视图即将出现的时候开始监听键盘动态
#pragma  mark -键盘的监听处理
- (void)viewWillAppear:(BOOL)animated
{
    //注册键盘出现的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark键盘出现的时候
//键盘出现的时候获取键盘高度.动画等属性, 并把这些属性给输入框
- (void)keyboardWasShown:(NSNotification *)noti
{
    // 获取键盘的 frame 数据
    CGRect  keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取键盘动画的种类
    int options = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    // 获取键盘动画的时长
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 修改文本框底部的约束的值
    self.bottomOfPassword.constant = keyboardFrame.size.height;
    
    // 在动画内调用 layoutIfNeeded 方法
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];

}
#pragma mark键盘消失的时候
//键盘消失的时候, 把给输入框高度还原
- (void)keyboardWillBeHidden:(NSNotification *)noti
{
    // 获取键盘动画的种类
    int options = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    // 获取键盘动画的时长
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.bottomOfPassword.constant = 0;
    
    // 在动画内调用 layoutIfNeeded 方法
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}
#pragma mark视图消失时取消键盘监听
//视图消失时取消键盘监听
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //取消注册过的通知
    //只按照通知的名字,取消掉具体的某个通知,而不是全部一次性取消掉所有注册过的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark -修改登录密码
- (IBAction)alterLoginPassword:(UIButton *)sender {
    //清空输入框并隐藏修改密码的视图
    [self cancerWrite];
    self.LoginOrCheck = 0;
    self.originalLoginPassword.placeholder = @"请输入旧登录密码";
    self.nnewLoginPassword.placeholder = @"请输入新的登录密码,不少于7位";
    self.repeatNewPassword.placeholder = @"再次输入密码";
}
#pragma mark -修改查询密码
- (IBAction)alterCheckPassword:(UIButton *)sender {
    //清空输入框并隐藏修改密码的视图
    [self cancerWrite];
    self.LoginOrCheck = 1;
    self.originalLoginPassword.placeholder = @"请输入原始查询密码";
    self.nnewLoginPassword.placeholder = @"请输入新的查询密码*不少于7位数";
    self.repeatNewPassword.placeholder = @"再次输入密码";
}
- (void)cancerWrite
{
    self.originalLoginPassword.text = @"";
    self.nnewLoginPassword.text = @"";
    self.repeatNewPassword.text = @"";
    //点击修改界面后显示修改界面
    self.loginView.hidden = NO;
}



//确定修改密码
- (IBAction)alterPassword:(UIButton *)sender {
    AAALoginParam *parm = [AAALoginParam sharedAAALoginParam];
  
    parm.nnewLoginPassword = self.nnewLoginPassword.text;
    //获取登录公司名称/员工号/密码
    switch (self.LoginOrCheck) {
        case 0:
        {
            NSLog(@"修改登录密码");
            
            //1. 判断旧的密码是否正确
            if ([self.originalLoginPassword.text  isEqual:parm.password])
            {
                //2. 判断新密码是否为空切字符个数大于7个
                if ([self.nnewLoginPassword.text length] >= 7)
                {
                    if ([self.nnewLoginPassword.text isEqualToString:self.repeatNewPassword.text]) {
                        NSLog(@"密码%@字符串长度 %lu",self.nnewLoginPassword.text,[self.nnewLoginPassword.text length]);
                        
                        //3. 提交新密码到服务器替换原始密码 参数： entname - 公司名称，empcode - 工号，oldpwd - 旧登陆密码，newpwd - 新登陆密码
                        [AAALoginTool alertLoginPassword:parm Success:^(BOOL result) {
                            NSLog(@"修改登陆密码:%d",result);
                            parm.password = self.nnewLoginPassword.text;
                        } Failure:^(NSError *error) {
                            
                        }];
                    }else{
                        [ [[UIAlertView alloc] initWithTitle:@"新密码错误" message:@"两次输入新密码不一致" delegate:self cancelButtonTitle:@"重新输入新密码" otherButtonTitles: nil] show];
                    }
                    
                }else{
                    //提示用户输入密码不能小于7位字符
                    [ [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"新密码长度不能小于7位" delegate:self cancelButtonTitle:@"重新输入新密码" otherButtonTitles: nil] show];
                }
            }else{
                //密码不正确
                [ [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"登录密码输入错误" delegate:self cancelButtonTitle:@"重新输入旧密码" otherButtonTitles: nil] show];
            }

        }
            break;
        case 1:
            NSLog(@"修改工资查询密码");
//        {
//            NSLog(@"修改查询密码");
//            //获取登录公司名称/员工号/   旧的查询密码 -- 新的查询密码   http://120.76.77.155:8003/Server.asmx/UpdateSalaryPwd?entname=百得电器&empcode=111714&oldpwd=123456&newpwd=123
//#warning 特殊的查看密码的接口 :传入参数: 公司名称/员工号
//            //获取原始工资密码, 原始的工资密码都是123456
//            NSString *url = [NSString stringWithFormat:aDirectToPasswords,orignalArray[0] ,orignalArray[1]];
//            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//            NSArray *passwordsArray = [NSArray array];
//            [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"%@",responseObject);
//                BOOL result = (BOOL )responseObject[@"result"];
//                NSLog(@"修改密码返回数据: %d",result);
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"%@",error);
//            }];
//            NSLog(@"返回的密码串:%@",passwordsArray);
//          //1. 判断旧的 查询 密码是否正确
//            if ([self.originalLoginPassword.text  isEqual:orignalArray[2]])
//            {
//                //2. 判断新密码是否为空切字符个数大于7个
//                if ([self.nnewLoginPassword.text length] >= 7)
//                {
//                    NSLog(@"密码%@字符串长度 %lu",self.nnewLoginPassword.text,[self.nnewLoginPassword.text length]);
//                    //3. 提交新密码到服务器替换原始密码 参数： entname - 公司名称，empcode - 工号，oldpwd - 旧登陆密码，newpwd - 新登陆密码
//                    //拼接请求url修改登录密码
//                    NSString *url = [NSString stringWithFormat:aHouseWebUpdateLoginPwd,orignalArray[0] ,orignalArray[1] ,orignalArray[2],self.nnewLoginPassword.text];
//                    NSLog(@"%@",url );
//                    
//                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//                    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                        NSLog(@"%@",responseObject);
//                        BOOL result = (BOOL )responseObject[@"result"];
//                        NSLog(@"修改密码返回数据: %d",result);
//                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                        NSLog(@"%@",error);
//                    }];
//                }else{
//                    //提示用户输入密码不能小于7位字符
//                    [ [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"新密码长度不能小于7位" delegate:self cancelButtonTitle:@"重新输入新密码" otherButtonTitles: nil] show];
//                }
//            }else{
//                //密码不正确
//                [ [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"登录密码输入错误" delegate:self cancelButtonTitle:@"重新输入旧密码" otherButtonTitles: nil] show];
//            }
//
//        }
            break;
            
        default:
            break;
    }
    self.loginView.hidden = YES;
    
}
//取消修改密码
- (IBAction)cancerToAlterPassword:(UIButton *)sender {
    //清空输入框并隐藏修改密码的视图
    self.originalLoginPassword.text = @"";
    self.nnewLoginPassword.text = @"";
    self.repeatNewPassword.text = @"";
    self.loginView.hidden = YES;
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
