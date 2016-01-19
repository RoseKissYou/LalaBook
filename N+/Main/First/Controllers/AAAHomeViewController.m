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

static NSString *identifier = @"firstCell";
@interface AAAHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
//广告界面
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
//悬浮按钮界面
@property (weak, nonatomic) IBOutlet UIButton *backToHeadButtonView;
//tableview界面
@property (weak, nonatomic) IBOutlet UITableView *hyTableView;

@end

@implementation AAAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"首页");
    [self setHeadTableView];
    self.backToHeadButtonView.hidden = YES;
    // Do any additional setup after loading the view.
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
        NSInteger totalCount = 3;
        //   1.添加5张图片
        for (int i = 0; i < totalCount; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] init];
            //        图片X
            CGFloat imageX = i * imageW;
            //        设置frame
            imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            //        设置图片
            NSString *name = [NSString stringWithFormat:@"headNews%d", i + 1];
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
    if (page == 2) {
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
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    AAAHomeTabCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell essayWithImageView:@"方形美女头像1.jpg" essayName:@"刘文"];
    // Configure the cell...
    
    return cell;
}
#pragma mark -监听滚动
- (IBAction)backToHeadView:(UIButton *)sender {
    //点击回到顶部
    [self.hyTableView setContentOffset:CGPointMake(0, 0) animated:YES];
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
