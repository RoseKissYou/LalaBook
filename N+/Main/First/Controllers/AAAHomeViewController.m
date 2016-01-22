//
//  AAAHomeViewController.m
//  BaseProject
//
//  Created by hy2 on 16/1/7.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAAHomeViewController.h"
#import "AAAHomeTabCell.h"
//发送邮件
#import <MessageUI/MessageUI.h>
//#import "EasyMailSender.h"
//#import "EasyMailAlertSender.h"
//检查账户是否登陆HR服务器
#import "loginHead.h"
#import "AAALoginAndRegionViewController.h"
static NSString *identifier = @"firstCell";
@interface AAAHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>
//广告界面
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
//悬浮按钮界面
@property (weak, nonatomic) IBOutlet UIButton *backToHeadButtonView;
//tableview界面
@property (weak, nonatomic) IBOutlet UITableView *hyTableView;
//总的代理视图
@property (weak, nonatomic) IBOutlet UIView *delegateView;

@end

@implementation AAAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"首页");
    self.delegateView.hidden = YES;
    [self checkUserNameAndPassword  ];
    //首先检查登陆单例里面有没有正确的用户名和密码, 否则本页弹出屏幕提示"没有输入公司信息, 无法获取公司动态"
    [self setHeadTableView];
    self.backToHeadButtonView.hidden = YES;
    // Do any additional setup after loading the view.
}
- (IBAction)delegateButton:(UIButton *)sender {
    [self checkUserNameAndPassword];
}
- (void)checkUserNameAndPassword
{
    //直接从登陆用户名密码里面的账户登陆
    AAALoginParam *param = [AAALoginParam sharedAAALoginParam];
    [AAALoginTool loginInWeb:param Success:^(BOOL result) {
        if (result) {
            //访问首页数据
            self.delegateView.hidden = NO;
        }else {
            //提示
            [[[UIAlertView alloc]initWithTitle:@"首页提示" message:@"您没有登陆公司账号" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登陆", nil] show];
            
        }
    } Failure:^(NSError *error) {
        
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    switch (buttonIndex) {
        case 0:
            NSLog(@"点击了取消");
            break;
        case 1:
        {
            //跳到注册
            UIStoryboard *loginStory = [UIStoryboard storyboardWithName:@"loginOrRegion" bundle:nil];
            
            
            AAALoginAndRegionViewController *chooseController = [loginStory instantiateViewControllerWithIdentifier:@"chooseNew"];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:chooseController];
            [self presentViewController:navi animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 设置headTableView
- (void)setHeadTableView
{
        //    图片的宽
        CGFloat imageW = self.scrollerview.frame.size.width;
        //    CGFloat imageW = 300;
        //    图片高
        CGFloat imageH = self.scrollerview.frame.size.height;
        //    图片的Y
        CGFloat imageY = 0;
        //    图片中数
        NSInteger totalCount = 6;
        //   1.添加5张图片
        for (int i = 0; i < totalCount; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            //        图片X
            CGFloat imageX = i * imageW;
            //        设置frame
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            //        设置图片
            NSString *name = [NSString stringWithFormat:@"%d.jpg", i + 1];
            imageView.image = [UIImage imageNamed:name];
            //        隐藏指示条
            self.scrollerview.showsHorizontalScrollIndicator = NO;
    
            [self.scrollerview addSubview:imageView];
        }
    
        //    2.设置scrollview的滚动范围
        CGFloat contentW = totalCount *imageW;
        //不允许在垂直方向上进行滚动
        self.scrollerview.contentSize = CGSizeMake(contentW, 0);
    
        //    3.设置分页
        self.scrollerview.pagingEnabled = YES;
        
        //    4.监听scrollview的滚动
        self.scrollerview.delegate = self;
        
        [self addTimer];
    }
- (void)nextImage
{
    int page = (int)self.pageControl.currentPage;
    if (page == 5) {
        page = 0;
    }else
    {
        page++;
    }
    
    //  滚动scrollview
    CGFloat x = page * self.scrollerview.frame.size.width;
    self.scrollerview.contentOffset = CGPointMake(x, 0);
}
// scrollview滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    //    计算页码
    //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pageControl.currentPage = page;
    
   
    ///判断按钮是否出现
    if ([scrollView isKindOfClass:[UITableView class]]) {
        CGFloat distance = scrollView.contentOffset.y;
        NSLog(@"%g",distance);
        if (distance >= 500) {
            NSLog(@"展现回到顶部");
            self.backToHeadButtonView.hidden = NO;
        }
    }
    
}

// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
    //    [self.timer invalidate];
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    开启定时器
    [self addTimer];
}

/**
 *  开启定时器
 */
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
  //  106
}
/**
 *  关闭定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return 11;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    AAAHomeTabCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //[cell essayWithImageView:@"截图11.png" essayName:@"刘文" withContentImage:@""];
    switch (indexPath.row) {
        case 0:
          [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 1:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 2:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 3:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 4:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 5:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 6:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 7:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 8:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 9:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
        case 10:
            [cell essayWithImageView:[NSString stringWithFormat:@"截图%ld",(long)indexPath.row] essayName:@"刘文" withContentImage:[NSString stringWithFormat:@"%ld.jpg",(long)indexPath.row]];
            break;
            
        default:
            break;
    }
   
    // Configure the cell...
    
    return cell;
}
#pragma mark -监听滚动
- (IBAction)backToHeadView:(UIButton *)sender {
    //点击回到顶部
    [self.hyTableView setContentOffset:CGPointMake(0, -64) animated:YES];
}


#pragma mark -发送邮件

//- (IBAction)sendEmail:(UIButton *)sender {
//    NSLog(@"点击了按钮");
//    NSString *attachedText = @"text";
//    
//    EasyMailAlertSender *mailSender = [EasyMailAlertSender easyMail:^(MFMailComposeViewController *controller) {
//        // Setup
//        [controller addAttachmentData:[attachedText dataUsingEncoding:NSUTF8StringEncoding] mimeType:@"plain/text" fileName:@"test.txt"];
//    } complete:^(MFMailComposeViewController *controller, MFMailComposeResult result, NSError *error) {
//        // When Sent/Cancel - MFMailComposeViewControllerDelegate action
//        [controller dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [mailSender showFromViewController:self competion:^{
//        [[[UIAlertView alloc] initWithTitle:@"Information" message:@"Mail View is presented" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//    }];
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
