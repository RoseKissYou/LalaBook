//
//  AAACheckViewController.m
//  BaseProject
//
//  Created by hy1 on 16/1/11.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAACheckViewController.h"

#import "checkHead.h"

@interface AAACheckViewController ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
///一
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UIView *btnViewOne;
//

///二
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UIView *btnViewTwo;
//

///三
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UIView *btnViewThree;
//

///四
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UIView *btnViewFour;
//

///五
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFive;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UIView *btnViewFive;
//

///六
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UIView *btnViewSix;
//

///七
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UIView *btnViewSeven;
//

///八
@property (weak, nonatomic) IBOutlet UIImageView *imageViewEight;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UIView *btnViewEight;
//

///九
@property (weak, nonatomic) IBOutlet UIImageView *imageViewNight;
@property (weak, nonatomic) IBOutlet UILabel *labelNight;
@property (weak, nonatomic) IBOutlet UIView *btnViewNight;
//

///十
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTen;
@property (weak, nonatomic) IBOutlet UILabel *labelTen;
@property (weak, nonatomic) IBOutlet UIView *btnViewTen;
//

///十一
@property (weak, nonatomic) IBOutlet UIImageView *imageViewEleven;
@property (weak, nonatomic) IBOutlet UILabel *labelEleven;
@property (weak, nonatomic) IBOutlet UIView *btnViewEleven;
//

///十二
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwelve;
@property (weak, nonatomic) IBOutlet UILabel *labelTwelve;
@property (weak, nonatomic) IBOutlet UIView *btnViewTwelve;
//


@property (nonatomic,strong) NSDictionary *dic;


//////////////////////////
@property (nonatomic,strong) VContentResult *result;

@end

@implementation AAACheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIView changeCorner:self.headerView radius:35.];
    
    [[AAASearchTool sharedAAASearchTool] getViewContent:nil Success:^(VContentResult *result) {
        self.result = result;
        //对界面进行布局
        [self showView:result];
    } Failure:^(NSError *error) {
        ;
    }];
    // Do any additional setup after loading the view.
    
}

///界面结构展示
- (void)showView:(VContentResult *)result{
    NSInteger count = 0 ;
    for (UIView *view in self.backgroundView.subviews) {
        if (view.tag < result.count.integerValue) {
            view.hidden = NO;
            VCDataInfoResult *re = result.datainfo[count];
            for (UIView *subview in view.subviews) {
                if ([subview isKindOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel *)subview;
                    label.text = [re.ModuleName stringByReplacingOccurrencesOfString:@"查询" withString:@""];
                }
                if ([subview isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView = (UIImageView *)subview;
                    imageView.image = [UIImage imageNamed:re.ModuleName];
                }
                if ([subview isKindOfClass:[ButtonWithModelName class]]) {
                    ButtonWithModelName *btn = (ButtonWithModelName *)subview;
                    btn.modelName = re.ModuleName;
                }
            }
        }else{
            view.hidden = YES;
        }
        count++;
    }
}
#pragma mark -移动考勤
- (IBAction)SignInByMove:(id)sender {
    AAASignInViewController *signInVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"signIn"];
    [self presentViewController:signInVC animated:YES completion:nil];
}
#pragma mark -查询功能
- (IBAction)clickButton:(ButtonWithModelName *)btn {
#warning df-当需要按钮对应的模块名字时，自定义按钮加上字符串属性
    if ([btn.modelName isEqualToString:@"日考勤查询"]) {
        SearchContentViewController *scVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"searchContent"];
        scVC.modelName = @"日考勤查询";
        [self.navigationController pushViewController:scVC animated:YES];
    }else if ([btn.modelName isEqualToString:@"工资查询"]){//调用第三方控件
        ZCTradeView *view = [[ZCTradeView alloc]init];
        [view show];
        view.finish = ^(NSString *pwd){
            NSLog(@"%@",pwd);
            //请求验证
            [[AAASearchTool sharedAAASearchTool]salaryPwdIsRight:pwd Success:^(BOOL result) {
                NSLog(@"%d",result);
#warning df-测试
                if (result) {
                    //进入工资查询界面
                    NSLog(@"进入工资查询界面");
                    SalaryViewController *sVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"Salary"];
                    self.navigationController.navigationBarHidden = NO;
                    [self.navigationController pushViewController:sVC animated:YES];
                }else{
                    //提示工资密码错误
                    NSLog(@"不能进入工资查询界面");
                    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"验证" message:@"工资密码错误" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    [ac addAction:aa];
                    [self presentViewController:ac animated:YES completion:nil];
                }
            } Failure:^(NSError *error) {
                ;
            }];
        };
    }else if ([btn.modelName isEqualToString:@"月考勤查询"]){
        MonthDetailViewController *mdVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"MonthDetail"];
        mdVC.modelName = @"月考勤查询";
        [self.navigationController pushViewController:mdVC animated:YES];
    }else if ([btn.modelName isEqualToString:@"档案查询"]){
        SearchFilesViewController *sfVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"SearchFile"];
        [self.navigationController pushViewController:sfVC animated:YES];
    }else if([btn.modelName isEqualToString:@"请假查询"]){
        LeaveTableViewController *lTVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"Leave"];
        [self.navigationController pushViewController:lTVC animated:YES];
    }else if ([btn.modelName isEqualToString:@"奖惩查询"]){
        RewardTableViewController *rTVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"Reward"];
        [self.navigationController pushViewController:rTVC animated:YES];
    }else if ([btn.modelName isEqualToString:@"订餐查询"]){
        MealRecondViewController *mrVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"MealRecond"];
    [self.navigationController pushViewController:mrVC animated:YES];
    }else if ([btn.modelName isEqualToString:@"加班查询"]){
        TimeAndConsViewController *tacVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"TimeAndCons"];
        [self.navigationController pushViewController:tacVC animated:YES];
    }else if ([btn.modelName isEqualToString:@"消费查询"]){
        ConsumeViewController *cVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"Consume"];
        [self.navigationController pushViewController:cVC animated:YES];
    }else if ([btn.modelName isEqualToString:@"签卡查询"]){
        ChargeCardViewController *ccVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"ChargeCard"];
        [self.navigationController pushViewController:ccVC animated:YES];
    }else if([btn.modelName isEqualToString:@"刷卡查询"]){
        PunchCardViewController *pcVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"PunchCard"];
        [self.navigationController pushViewController:pcVC animated:YES];
    }
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
