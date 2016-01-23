//
//  AAASendMiController.m
//  BaseProject
//
//  Created by hy1 on 16/1/9.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAASendMiController.h"

@interface AAASendMiController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
///私信内容
@property (weak, nonatomic) IBOutlet UITextView *sendContentTV;
///图片信息
@property (weak, nonatomic) IBOutlet UIImageView *sendImage;
@end

@implementation AAASendMiController

- (IBAction)back2Home:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

///调用相机
- (IBAction)go2Camera:(id)sender {
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType= UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 点击相册中的图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.sendImage.image = [UIImage imageWithData:UIImagePNGRepresentation(image)];
    self.sendImage.clipsToBounds = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
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
