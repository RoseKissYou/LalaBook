//
//  NaviController.m
//  N+
//
//  Created by hy1 on 16/1/20.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "NaviController.h"

@interface NaviController ()

@end

@implementation NaviController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count != 0) {
        self.navigationBarHidden = NO;
    }
    [super pushViewController:viewController animated:animated];
}



- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.count == 2) {
        self.navigationBarHidden = YES;
    }
    return [super popViewControllerAnimated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
