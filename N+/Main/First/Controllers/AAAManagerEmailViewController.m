//
//  AAAManagerEmailViewController.m
//  N+
//
//  Created by hy2 on 16/1/23.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAAManagerEmailViewController.h"

@interface AAAManagerEmailViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//邮件内容
@property (weak, nonatomic) IBOutlet UITextView *emailContentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageOneView;
@property (weak, nonatomic) IBOutlet UIImageView *imageTwoView;
@property (weak, nonatomic) IBOutlet UIImageView *imageThreeView;

@property (weak, nonatomic) IBOutlet UIView *addImageBaseView;
@property (weak, nonatomic) IBOutlet UIButton *emailTopicButtonText;
//匿名
@property (weak, nonatomic) IBOutlet UIImageView *noneNameImageView;
@property (weak, nonatomic) IBOutlet UILabel *noneNameImageLabel;


@end

@implementation AAAManagerEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//
#pragma mark -点击选择主题
- (IBAction)clickSelectTopic:(UIButton *)sender {
    [[[UIAlertView alloc ]initWithTitle:@"主题" message:@"请选择发给总经理邮件的主题" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"投诉",@"建议",nil] show ];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self.emailTopicButtonText setTitle:@"点击选择邮件主题" forState:UIControlStateNormal];
            break;
        case 1:
            [self.emailTopicButtonText setTitle:@"投诉" forState:UIControlStateNormal];
            break;
        case 2:
           [self.emailTopicButtonText setTitle:@"建议" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}
#pragma mark -点击添加照片
- (IBAction)addImageFormCameraORPhones:(UIButton *)sender {
    //先判断图片框中有没有空余的位置放图片, 如果没有就弹屏提示最多加载三张图片
    if ((self.imageOneView.image == nil ) | (self.imageThreeView.image == nil) | (self.imageTwoView.image == nil )) {
        [self getPhotoFromCameraOrPhotos];
    }else{
        [[[UIAlertView alloc] initWithTitle:@"图片已满" message:@"最多可以发3张图片" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
    }
}
- (void) getPhotoFromCameraOrPhotos
{
    UIAlertController * alertViewController = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction * actionCamera = [UIAlertAction actionWithTitle:@"照相机" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            NSLog(@"照相机");
            UIImagePickerController  *pc = [[UIImagePickerController alloc]init];
            pc.allowsEditing = YES;
            pc.sourceType = UIImagePickerControllerCameraCaptureModeVideo;
            pc.delegate = self;
            [self presentViewController:pc animated:YES completion:nil];
        }
    }];
    UIAlertAction * actionPic = [UIAlertAction actionWithTitle:@"图库" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"相册");
        UIImagePickerController  *pc = [[UIImagePickerController alloc]init];
        pc.allowsEditing = YES;
        pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pc.delegate = self;
        [self presentViewController:pc animated:YES completion:nil];
    }];
    [alertViewController addAction:actionCancel];
    [alertViewController addAction:actionCamera];
    [alertViewController addAction:actionPic];
    [self presentViewController:alertViewController animated:YES completion:nil];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    //把取到的图片给显示图片列去
    [self addImageOToViewsBy:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//判断图片
- (void) addImageOToViewsBy:(UIImage *)image
{NSLog(@"添加图片");
    if (self.imageOneView.image != nil)
    {
        if (self.imageTwoView.image != nil)
        {
            if (self.imageThreeView.image != nil)
            {
                NSLog(@"最多只能添加3张图片");
            }else{self.imageThreeView.image = image;}
        }else{self.imageTwoView.image = image;}
    }else{self.imageOneView.image = image;}
}
#pragma mark -匿名切换
- (IBAction)switchToRealName:(UISwitch *)sender {
    //点击切换为实名
//    UISwitch *mySwitch = (UISwitch *)sender;
//    if ([mySwitch isOn]) {
//        //显示匿名anonymous
//        self.noneNameImageView.image = [UIImage imageNamed:@"anonymous"];
//        self.noneNameImageLabel.text = @"匿名";
//    }else{
//        self.noneNameImageView.image = [UIImage imageNamed:@"house_hili"];
//        self.noneNameImageLabel.text = @"实名";
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -返回
- (IBAction)backToFirst:(UIBarButtonItem *)sender {
#warning 返回到了登陆界面, 不是首页, 待检查
    [self dismissViewControllerAnimated:YES completion:nil];
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
