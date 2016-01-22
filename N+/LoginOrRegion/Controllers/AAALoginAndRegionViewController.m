//
//  AAALoginAndRegionViewController.m
//  N+
//
//  Created by hy2 on 16/1/18.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAALoginAndRegionViewController.h"

#import "loginHead.h"

#import "NSString+CN2UTF8.h"

//纯代码TabBar
#import "AAATabBarController.h"

//旧版扫一扫
#import "QRCodeReaderViewController.h"
@import AVFoundation;
static NSInteger changeHeightLayout = 30;
static NSInteger originalHeightLayout = 50;
static NSInteger bossTopLayout = 90;
static NSInteger bossOriginalLayout = 10;
@interface AAALoginAndRegionViewController ()<AVCaptureMetadataOutputObjectsDelegate,MBProgressHUDDelegate,QRCodeReaderDelegate,UITextFieldDelegate>
//公司全称
@property (weak, nonatomic) IBOutlet UITextField *corporationName;
//员工号
@property (weak, nonatomic) IBOutlet UITextField *userNumber;

//密码
@property (weak, nonatomic) IBOutlet UITextField *passWordTextFiled;
//手机号码
@property (weak, nonatomic) IBOutlet UITextField *telephoneTF;

//扫描后拿到的字符串
@property (nonatomic,strong) NSString *codeScanStr;
//切换视图
@property (weak, nonatomic) IBOutlet UIView *regionView;

@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subViewBottomLayout;
//登陆界面
@property (weak, nonatomic) IBOutlet UITextField *userLoginNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *userLoginPasswordTextField;
//修改登陆界面的顶部layout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logionReviseLayoutTop;
//修改注册界面
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *companyTopLayoutBoss; //总layout下降90
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNumberHeightLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordHeightLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userPhoneHeightLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *regionBottomLayout;  //30
//企业员工或非企业员工登陆按钮视图顶部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chooseCompanyOrNotTopLayout; //默认是20 键盘弹起后变成90
//公司名称view
@property (weak, nonatomic) IBOutlet UIView *companyNameView;
//公司名称view高度 默认是50
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *companyNameViewHeightLayout;
//企业注册按钮视图
@property (weak, nonatomic) IBOutlet UIButton *companyRegisterButtonView;
@property (weak, nonatomic) IBOutlet UIButton *notCompanyRegisterButtonView;

//非企业注册按钮视图
@property (weak, nonatomic) IBOutlet UIButton *clickCompanyRegisterButton;
@property (weak, nonatomic) IBOutlet UIButton *clickNotCompanyRegisterButton;

@end

@implementation AAALoginAndRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    //初始隐藏登陆视图
    self.loginView.hidden = NO;
    self.regionView.hidden = YES;
    [self setTextFiledFormat];
    
    // Do any additional setup after loading the view.
}
#pragma mark - 选择登陆或者注册
//点击登陆按钮 -> 隐藏 新用户注册视图
- (IBAction)chooseLogin:(UIButton *)sender {
    self.regionView.hidden = YES;
    self.loginView.hidden = NO;
}
- (IBAction)chooseRegion:(UIButton *)sender {
    self.loginView.hidden = YES;
    self.regionView.hidden = NO;
    //改变企业注册按钮的颜色
    [self.clickCompanyRegisterButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.clickNotCompanyRegisterButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
#pragma mark -return按钮设置
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //如果是输入corporationName 员工号 密码 或者登陆名 return 下一个输入框 
    if ([string isEqual:@"\n"]) {
        NSLog(@"按下return执行下一行");
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - 注册
- (IBAction)regionToServer:(UIButton *)sender {
    NSLog(@"企业注册按钮");
    [self.view endEditing:YES];
   
    AAALoginParam *param = [AAALoginParam sharedAAALoginParam];
#warning df-self.codeScanStr这个参数在真机调试时换上
    param.corporationName = [NSString CNToUTF8:@"百得电器"];
    param.staffNummber = self.userNumber.text;
    param.password = self.passWordTextFiled.text;
    param.userPasswordInWeb = param.password;
    if (self.telephoneTF.text.length != 11) {
#warning 加上交互
        return;
    }else{
        param.telephone = self.telephoneTF.text;
        [AAALoginTool registerInWeb:param Success:^(NSString *userid) {
            param.userNameInWeb = userid;
            [self chooseLogin:nil];
            self.userLoginNameTextField.text = param.userNameInWeb;
            self.userLoginPasswordTextField.text = param.userPasswordInWeb;
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}
#pragma mark - 登录
- (IBAction)LoginToMianButton:(UIButton *)sender {
    AAALoginParam *param = [AAALoginParam sharedAAALoginParam];
    //这里把用户名和密码存在单例里面,
    param.userNameInWeb = self.userLoginNameTextField.text;
    param.userPasswordInWeb = self.userLoginPasswordTextField.text;
    [AAALoginTool loginInWeb:param Success:^(BOOL result) {
        //去HR服务器查找员工号存不存在
        [AAALoginTool stateOfStaff:param Success:^(AAALoginResult *result) {
            //根据result来把设定权限
#warning df-权限设定
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        NSLog(@"%d",result);
        if (result == 1) {
            //跳转到主页
            AAATabBarController *tabBar = [[AAATabBarController alloc] init];
//            UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            AAAHomeViewController *firstControl = [mainStory instantiateViewControllerWithIdentifier:@"Main"];
            [self presentViewController:tabBar animated:YES completion:nil];
        }else {
            [[[UIAlertView alloc] initWithTitle:@"登陆错误" message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"重新输入" otherButtonTitles: nil] show];
        }
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


//加上一些互交
- (void)hujiao1{
    //方式1.直接在View上show
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.delegate = self;
    //常用的设置
    //小矩形的背景色
    HUD.color = [UIColor blackColor];//这儿表示无背景
    //显示的文字
    HUD.labelText = @"登录错误";
    //细节文字
    HUD.detailsLabelText = @"请输入正确的员工号和密码";
    //是否有庶罩
    HUD.dimBackground = YES;
    [HUD hide:YES afterDelay:2];
}

//go2Main
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
    AAATabBarController *tabBar = [[AAATabBarController alloc] init];
    
    [self presentViewController:tabBar animated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 扫码
- (IBAction)tranditionalCodeScan:(UIButton *)sender {
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];\
    reader.modalPresentationStyle = UIModalPresentationFormSheet;
    reader.delegate = self;
    
    __weak typeof (self) wSelf = self;
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        [wSelf.navigationController popViewControllerAnimated:YES];
        [[[UIAlertView alloc] initWithTitle:@"" message:resultAsString delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
    }];
    
    //[self presentViewController:reader animated:YES completion:NULL];
    [self.navigationController pushViewController:reader animated:YES];
}

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    self.corporationName.text = result;
    self.codeScanStr = result;
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
#pragma mark - 键盘弹起
//view看的见时,增加注册监听键盘
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //增加键盘的弹起通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    //增加键盘的收起通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
}
// 有键盘弹起,此方法就会被自动执行
-(void)openKeyboard:(NSNotification *)noti
{
    // 获取键盘的 frame 数据
    CGRect  keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取键盘动画的种类
    int options = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    // 获取键盘动画的时长
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 修改文本框底部的约束的值
    self.subViewBottomLayout.constant = keyboardFrame.size.height;
    //修改界面layout
    [self reviseViewLayout];
    
    // 在动画内调用 layoutIfNeeded 方法
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
}
//修改界面layout
- (void)reviseViewLayout
{
    //同时修改登陆框的顶部layout
    self.logionReviseLayoutTop.constant = 130;
    //修改注册界面
    self.companyTopLayoutBoss.constant = bossTopLayout;
    self.userNumberHeightLayout.constant = changeHeightLayout;
    self.passwordHeightLayout.constant = changeHeightLayout;
    self.userPhoneHeightLayout.constant = changeHeightLayout;
    //企业非企业
    self.chooseCompanyOrNotTopLayout.constant = bossTopLayout;
    
}

-(void)closeKeyboard:(NSNotification *)noti
{
    // 获取键盘动画的种类
    int options = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    // 获取键盘动画的时长
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘消失就让视图还原
    self.subViewBottomLayout.constant = 0;
    //还原界面layout
    [self resumeViewLayout];
    // 在动画内调用 layoutIfNeeded 方法
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
}
- (void) resumeViewLayout
{
    //登陆界面
    self.logionReviseLayoutTop.constant = 40;
    //注册界面
    self.companyTopLayoutBoss.constant = bossOriginalLayout;
    self.userNumberHeightLayout.constant = originalHeightLayout;
    self.passwordHeightLayout.constant = originalHeightLayout;
    self.userPhoneHeightLayout.constant = originalHeightLayout;
    //self.regionBottomLayout.constant = 30;
    self.chooseCompanyOrNotTopLayout.constant = 20;
}
//键盘消失时取消监听
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //增加键盘的弹起通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    //增加键盘的收起通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)setTextFiledFormat
{
    [self registerViewAddImages];
    //设置登陆界面的
    UIImageView *leftLU = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gonghaoming"]];
    leftLU.contentMode = UIViewContentModeCenter;
    leftLU.frame = CGRectMake(0, 0, 30, 20);
    self.userLoginNameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.userLoginNameTextField.leftView = leftLU;
    
    UIImageView *leftLP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mima"]];
    leftLP.contentMode = UIViewContentModeCenter;
    leftLP.frame = CGRectMake(0, 0, 30, 20);
    self.userLoginPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.userLoginPasswordTextField.leftView = leftLP;
}
//注册界面TextField 图片加入
- (void)registerViewAddImages
{
    UIImageView *leftVN = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gonghaoming"]];
    leftVN.contentMode = UIViewContentModeCenter;
    leftVN.frame = CGRectMake(0, 0, 30, 20);
    self.userNumber.leftViewMode = UITextFieldViewModeAlways;
    self.userNumber.leftView = leftVN;
    UIImageView *leftVP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mima"]];
    leftVP.contentMode = UIViewContentModeCenter;
    leftVP.frame = CGRectMake(0, 0, 30, 20);
    self.passWordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.passWordTextFiled.leftView = leftVP;
    
    UIImageView *leftVC = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dianhua"]];
    leftVC.contentMode = UIViewContentModeCenter;
    leftVC.frame = CGRectMake(0, 0, 30, 20);
    self.telephoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.telephoneTF.leftView = leftVC;
}
//界面TextField 图片更换
- (void) changeRegisterAddImages
{
    UIImageView *leftVN = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dianhua"]];
    leftVN.contentMode = UIViewContentModeCenter;
    leftVN.frame = CGRectMake(0, 0, 30, 20);
    self.userNumber.leftViewMode = UITextFieldViewModeAlways;
    self.userNumber.leftView = leftVN;
    UIImageView *leftVP = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mima"]];
    leftVP.contentMode = UIViewContentModeCenter;
    leftVP.frame = CGRectMake(0, 0, 30, 20);
    self.passWordTextFiled.leftViewMode = UITextFieldViewModeAlways;
    self.passWordTextFiled.leftView = leftVP;
    
    UIImageView *leftVC = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mima"]];
    leftVC.contentMode = UIViewContentModeCenter;
    leftVC.frame = CGRectMake(0, 0, 30, 20);
    self.telephoneTF.leftViewMode = UITextFieldViewModeAlways;
    self.telephoneTF.leftView = leftVC;
}

#pragma mark - 企业或非企业员工
- (IBAction)companyRegisterChooseButton:(UIButton *)sender {
    //改变两个按钮的颜色状态
    [self.clickNotCompanyRegisterButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.clickCompanyRegisterButton setTitle:@"输入企业用户信息" forState:UIControlStateNormal];
    [self.clickCompanyRegisterButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal ];
    //
    self.companyNameView.hidden = NO;
    self.companyNameViewHeightLayout.constant = 50;
    //剩下的三个输入框分别变成 员工号  员工密码 手机号
    self.userNumber.placeholder = @"请输入员工号";
    self.passWordTextFiled.placeholder = @"请输入密码";
    self.telephoneTF.placeholder = @"请输入真实手机号码";
    [self registerViewAddImages];
    //隐藏非企业注册按钮,  出现企业登陆按钮
    self.notCompanyRegisterButtonView.hidden = YES;
    self.companyRegisterButtonView.hidden = NO;
}


//非企业员工注册
- (IBAction)notCompanyMemberRegister:(UIButton *)sender {
    //改变两个按钮的颜色状态
    [self.clickCompanyRegisterButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.clickNotCompanyRegisterButton setTitle:@"输入非企业用户信息" forState:UIControlStateNormal];
    [self.clickNotCompanyRegisterButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal ];
    //隐藏公司名称view
    self.companyNameView.hidden = YES;
    self.companyNameViewHeightLayout.constant = 0;
   //剩下的三个输入框分别变成 员工号 -> 请输入手机号 员工密码->新密码 手机号 -> 再次输入新密码
    self.userNumber.placeholder = @"请输入注册手机号";
    self.passWordTextFiled.placeholder = @"请输入新密码";
    self.telephoneTF.placeholder = @"请再次输入密码";
    [self changeRegisterAddImages];
    
    self.notCompanyRegisterButtonView.hidden = NO;
    self.companyRegisterButtonView.hidden = YES;
    
}
- (IBAction)notCompanyRegisterButton:(UIButton *)sender {
    //非企业注册按钮
    NSLog(@"非企业注册按钮");
    //注册到云端, 没有HR账户, 直接跳转
    AAATabBarController *tabBar = [[AAATabBarController alloc] init];
    
    [self presentViewController:tabBar animated:YES completion:nil];
    
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
