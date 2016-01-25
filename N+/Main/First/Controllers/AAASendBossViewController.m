//
//  AAASendBossViewController.m
//  N+
//
//  Created by hy2 on 16/1/23.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAASendBossViewController.h"

@interface AAASendBossViewController ()<UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>
//底层view
@property (strong, nonatomic) UIView *BaseView;
//搭建滚动视图
@property (strong, nonatomic) UIScrollView *MyScrollView;
@end

@implementation AAASendBossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect superBounds = self.view.bounds;
    //底层view
    UIView *baseView = [[UIView alloc] initWithFrame:superBounds];
    self.BaseView = baseView;
    [self.view addSubview:baseView];
    //搭建滚动视图
    
    // Do any additional setup after loading the view from its nib.
}
//搭建滚动视图
- (void) setMyScrollView
{
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:self.BaseView.bounds];
    self.MyScrollView = myScrollView;
    [self.BaseView addSubview:myScrollView];
    
    //主题 + 按钮选择 投诉/建议
    UILabel *topicLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 76, 50, 20)];
    topicLabel.text = @"主题";
    //按钮选择 投诉/建议
    UIButton *selectAdviseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    selectAdviseButton.frame = CGRectMake(topicLabel.frame.size.width + 5, 66, self.BaseView.frame.size.width - topicLabel.frame.size.width - 5, 35);
    [selectAdviseButton setTitle:@"请选择邮件主题" forState:UIControlStateNormal];
    
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
