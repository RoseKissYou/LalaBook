//
//  AAAHouseBaseViewController.m
//  N+
//
//  Created by hy2 on 16/1/15.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAAHouseBaseViewController.h"

@interface AAAHouseBaseViewController ()
//天气背景图片
@property (weak, nonatomic) IBOutlet UIImageView *weatherBackgroudImageView;

@property (weak, nonatomic) IBOutlet UIView *tableHeadBaseView;

@end

@implementation AAAHouseBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
