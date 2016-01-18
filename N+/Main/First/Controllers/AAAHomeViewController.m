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
@interface AAAHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AAAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"首页");
    // Do any additional setup after loading the view.
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    AAAHomeTabCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell essayWithImageView:@"方形美女头像1.jpg" essayName:@"刘文"];
    // Configure the cell...
    
    return cell;
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
