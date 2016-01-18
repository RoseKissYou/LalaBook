//
//  AAACheckViewController.m
//  BaseProject
//
//  Created by hy1 on 16/1/11.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAACheckViewController.h"
#import "AAASignInViewController.h"
#import "SearchContentViewController.h"
#import "ButtonWithModelName.h"


#import "AAASearchTool.h"
#import "VContentResult.h"
#import "VCDataInfoResult.h"

#import "ZCTradeView.h"

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
    
    self.headerView.layer.cornerRadius = 35.0;
    self.headerView.layer.masksToBounds = YES;
    
    
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
                    label.text = re.ModuleName;
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

- (IBAction)SignInByMove:(id)sender {
    AAASignInViewController *signInVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"signIn"];
    [self presentViewController:signInVC animated:YES completion:nil];
}

- (IBAction)clickButton:(ButtonWithModelName *)btn {
#warning df-当需要按钮对应的模块名字时，自定义按钮加上字符串属性
    if ([btn.modelName isEqualToString:@"日考勤查询"]) {
        SearchContentViewController *scVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@"searchContent"];
        scVC.modelName = btn.modelName;
        [self.navigationController pushViewController:scVC animated:YES];
    }else if ([btn.modelName isEqualToString:@"工资查询"]){//调用第三方控件
        ZCTradeView *view = [[ZCTradeView alloc]init];
        [view show];
        view.finish = ^(NSString *pwd){
            NSLog(@"%@",pwd);
            //请求验证
            [[AAASearchTool sharedAAASearchTool]salaryPwdIsRight:pwd Success:^(BOOL result) {
                NSLog(@"%d",result);
                if (result) {
                    //进入工资查询界面
                    NSLog(@"进入工资查询界面");
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
        SearchContentViewController *scVC = [[UIStoryboard storyboardWithName:@"check" bundle:nil] instantiateViewControllerWithIdentifier:@""];
        scVC.modelName = btn.modelName;
        [self.navigationController pushViewController:scVC animated:YES];
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
