//
//  AAALoginAndRegionViewController.m
//  N+
//
//  Created by hy2 on 16/1/18.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAALoginAndRegionViewController.h"

#import "loginHead.h"
@import AVFoundation;

@interface AAALoginAndRegionViewController ()<AVCaptureMetadataOutputObjectsDelegate,MBProgressHUDDelegate>
//公司全称
@property (weak, nonatomic) IBOutlet UITextField *corporationName;
//员工号
@property (weak, nonatomic) IBOutlet UITextField *userNumber;

//密码
@property (weak, nonatomic) IBOutlet UITextField *passWordTextFiled;
//手机号码
@property (weak, nonatomic) IBOutlet UITextField *telephoneTF;

/*************************************************/
//管道 -- 连接输出输入流
@property (nonatomic,strong)AVCaptureSession *session;

//用于展示输出流到界面上的视图
@property(nonatomic,strong) AVCaptureVideoPreviewLayer *videoLayer;
//扫描后拿到的字符串
@property (nonatomic,strong) NSString *str;
//切换视图
@property (weak, nonatomic) IBOutlet UIView *regionView;

@property (weak, nonatomic) IBOutlet UIView *loginView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subViewBottomLayout;
//登陆界面
@property (weak, nonatomic) IBOutlet UITextField *userLoginNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *userLoginPasswordTextField;


@end

@implementation AAALoginAndRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始隐藏登陆视图
    self.loginView.hidden = YES;
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
}
- (void)setTextFiledFormat
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

#pragma mark - 注册
- (IBAction)regionToServer:(UIButton *)sender {
    [self.view endEditing:YES];
    /**
     *  我们这里的接收数据要包含: 公司ID 公司服务器域名
     http://url/login.ashx?entname=@entname&empcode=@empcode&pwd=@pwd
     */
    
    /**
     *  等待数据接口访问数据
     */
    AAALoginParam *param = [AAALoginParam sharedAAALoginParam];
    param.corporationName = self.str;
#warning df-写死测试
    param.corporationName =[@"百得电器" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    param.staffName = self.userNumber.text;
    param.password = self.passWordTextFiled.text;
    if (self.telephoneTF.text.length != 11) {
        return;
    }else{
        [AAALoginParam sharedAAALoginParam].telephone = self.telephoneTF.text;
        
        [AAALoginTool registerTelephone:[AAALoginParam sharedAAALoginParam] Success:^(BOOL result) {
            if (result) {
                //注册成功
                [self go2Main];
            }else{
                //注册失败
                //提醒重新输入
            }
        } Failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }

    [AAALoginTool loginUseTool:param Success:^(NSInteger result) {
        switch (result) {
            case 0:
                [self hujiao1];
                NSLog(@"登录错误");
                //                param.address = [AAALocationStr sharedAAALocationStr].locationStr;
                //提示重新输入
                break;
            case 1:
            {
                NSLog(@"登录正确，且已注册");
                //跳转到首页
                [self go2Main];
                break;
            }
           
            default:
                break;
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
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AAAHomeViewController *firstControl = [mainStory instantiateViewControllerWithIdentifier:@"Main"];
    [self presentViewController:firstControl animated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)ScanTheCode:(UIButton *)sender {
    [self scanCodeWithImage];
}

#pragma mark - 扫码
- (void)scanCodeWithImage{
    //获取后置摄像头的管理对象, Capture:捕获
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 从摄像头捕获输入流
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"error %@", error);
        return;
    }
    //  创建输出流-->把图像输入到屏幕上显示
    AVCaptureMetadataOutput *output = [AVCaptureMetadataOutput new];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //  需要一个管道连接输入和输出
    _session = [AVCaptureSession new];
    [_session addInput:input];
    [_session addOutput:output];
    //  管道可以规定质量,  流畅/高清/标清
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
#warning 设置输出流监听 二维码/条形码, 必须在管道接通之后设置!!!
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,  AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeEAN8Code];
    //把画面输入到屏幕上,给用户看
    _videoLayer=[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _videoLayer.frame = self.view.frame;
    [self.view.layer addSublayer:_videoLayer];
    
    // 启动管道
    [_session startRunning];
    
}

#pragma mark - 当扫描到我们想要的数据时,触发
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    //    metadataObjects 数组中 存放的就是扫描出的数据
    if (metadataObjects.count > 0) {
        //  如果扫描到, 关闭管道,去掉扫描显示
        [_session stopRunning];
        [_videoLayer removeFromSuperlayer];
        
        //拿扫描到的数据
        AVMetadataMachineReadableCodeObject *obj = metadataObjects.firstObject;
        //把解析到的公司全名返回给label显示
        self.corporationName.text = obj.stringValue;
        //把中文预先转成utf-8
        self.str = [obj.stringValue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
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
    
    // 在动画内调用 layoutIfNeeded 方法
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
}

-(void)closeKeyboard:(NSNotification *)noti
{
    // 获取键盘动画的种类
    int options = [noti.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    // 获取键盘动画的时长
    NSTimeInterval duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.subViewBottomLayout.constant = 0;
    
    // 在动画内调用 layoutIfNeeded 方法
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
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
#pragma mark - 登陆
- (IBAction)LoginToMianButton:(UIButton *)sender {
    AAALoginParam *param = [AAALoginParam sharedAAALoginParam];
    //这里把用户名和密码存在单例里面,
    
    if (self.userLoginPasswordTextField.text == nil || self.userLoginNameTextField.text == nil) {
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
