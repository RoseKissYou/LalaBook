//
//  MGViewController.m
//  MGSpotyView
//
//  Created by Matteo Gobbi on 25/06/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGViewController.h"
#import "MGViewControllerDataSource.h"
#import "MGViewControllerDelegate.h"

#import "houseName.h"
@interface MGViewController ()

@end



@implementation MGViewController {
    MGViewControllerDelegate *delegate_;
    MGViewControllerDataSource *dataSource_;
}

- (instancetype)initWithMainImage:(UIImage *)image
{
    self = [super initWithMainImage:image tableScrollingType:MGSpotyViewTableScrollingTypeNormal]; //or MGSpotyViewTableScrollingTypeOver
    if (self) {
        dataSource_ = [MGViewControllerDataSource new];
        delegate_ = [MGViewControllerDelegate new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = dataSource_;
    self.delegate = delegate_;
    
    [self setOverView:self.myOverView];
}

- (UIView *)myOverView
{
    UIView *view = [[UIView alloc] initWithFrame:self.overView.bounds];
    
    [self mg_addElementOnView:view];
    
    return view;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Private methods

- (void)mg_addElementOnView:(UIView *)view
{
    //事例图片视图
    UIView *itemsContainer = [UIView new];
    itemsContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:itemsContainer];
    
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setClipsToBounds:YES];
    [imageView setImage:[UIImage imageNamed:userSmallImage]];
    [imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [imageView.layer setBorderWidth:2.0];
    [imageView.layer setCornerRadius:45.0];
    imageView.userInteractionEnabled = YES;
    [itemsContainer addSubview:imageView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [imageView addGestureRecognizer:tapRecognizer];
    
    
    //设置名字
    UILabel *lblTitle = [UILabel new];
    lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [lblTitle setText:userName];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:25.0]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:[UIColor whiteColor]];
    lblTitle.numberOfLines = 0;
    lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [itemsContainer addSubview:lblTitle];
    
    
    //设置个人信息 ,很萌很善良的软妹子.却又可以为了梦想而疯狂
    UIButton *btContact = [UIButton buttonWithType:UIButtonTypeCustom];
    btContact.translatesAutoresizingMaskIntoConstraints = NO;
    [btContact setTitle:userDescribe forState:UIControlStateNormal];
    [btContact addTarget:self action:@selector(actionContact:) forControlEvents:UIControlEventTouchUpInside];
    btContact.backgroundColor = [UIColor darkGrayColor];
    btContact.titleLabel.font = [UIFont fontWithName:@"Verdana" size:12.0];
    btContact.layer.cornerRadius = 5.0;
    [itemsContainer addSubview:btContact];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:itemsContainer attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:itemsContainer attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    NSDictionary *items = NSDictionaryOfVariableBindings(imageView, lblTitle, btContact);
    [items enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [itemsContainer addConstraint:[NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:itemsContainer attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    }];
    
    [itemsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(90)]" options:0 metrics:nil views:items]];
    [itemsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[btContact(70)]" options:0 metrics:nil views:items]];
    [itemsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lblTitle]-10-|" options:0 metrics:nil views:items]];
    
    [itemsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView(90)]-10-[lblTitle]-10-[btContact(30)]|" options:0 metrics:nil views:items]];
}


#pragma mark - Action
//点击信息弹屏
- (void)actionContact:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"个性标签" message:@"呆呆傻傻就是我" delegate:nil cancelButtonTitle:@"看我也是这样" otherButtonTitles:nil] show];
}


#pragma mark - Gesture recognizer

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [[[UIAlertView alloc] initWithTitle:@"触碰心灵" message:@"爱我的人都是好人" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil] show];
    }
}


@end