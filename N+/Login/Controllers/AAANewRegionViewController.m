//
//  AAANewRegionViewController.m
//  N+
//
//  Created by hy2 on 16/1/18.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAANewRegionViewController.h"

#import "AAALoginTool.h"
#import "AAALoginParam.h"

#import "AAAHomeViewController.h"

#import "AAALocationStr.h"

@interface AAANewRegionViewController ()<AVCaptureMetadataOutputObjectsDelegate,MBProgressHUDDelegate>
//公司全称: 可通过输入或者扫一扫获得
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

@end

@implementation AAANewRegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)clickRegion:(UIButton *)sender {
    
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
    param.phoneType = self.telephoneTF.text;
    
    [AAALoginTool loginUseTool:param Success:^(NSInteger result) {
        switch (result) {
            case 0:
                [self hujiao1];
                NSLog(@"登录错误");
                // param.address = [AAALocationStr sharedAAALocationStr].locationStr;
                //提示重新输入
                break;
            case 1:
            {
                NSLog(@"登录正确，且已注册");
                //跳转到首页
                [self go2Main];
                break;
            }
                //没有手机号码的隐藏
//            case 2:
//            {
//                NSLog(@"登录正确，未注册");
//#warning df-把协议内容置顶
//                [self.protocolTextView setContentOffset:CGPointMake(0, 0)];
//                //手机号码输入页
//                self.loginView.hidden = YES;
//                self.telephoneView.hidden = NO;
//                break;
//            }
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
- (IBAction)scanCode:(id)sender {
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
