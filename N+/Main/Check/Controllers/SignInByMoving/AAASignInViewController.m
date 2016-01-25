//
//  AAASignInViewController.m
//  BaseProject
//
//  Created by hy1 on 16/1/11.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAASignInViewController.h"
#import <MapKit/MapKit.h>

@interface AAASignInViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation AAASignInViewController


- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化manager
    self.manager = [CLLocationManager new];
    //征求用户同意(假定同意/Info.plist中key)
    [self.manager requestWhenInUseAuthorization];
    //设置代理
    self.mapView.delegate = self;
    
    //设置不允许旋转
//    self.mapView.rotateEnabled = NO;
    //设置地图的显示类型(默认是standard类型)
//    self.mapView.mapType = MKMapTypeHybrid;
    
    //设定地图属性(开始定位/显示在地图上)
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -返回
- (IBAction)back2CheckVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*1.移动签到确认接口
 当点确认签到时，往服务器回传数据调用该接口，数据保存到云服务器，与HR服务器无关；
 接口格式：http://url/phonesign?userid=@userid&signaddr=@signaddr
 @userid ： 当前登录的云账号
 @signaddr ： 签到的位置地点
 返回：True 签到成功，False 签到失败；
 接口处理逻辑：
 {
 //直接调用语句插入记录
 Insert into tsys_phonesign(userid,yymmdd,signtime,signaddr)
 Valule(@userid,convert(varchar(10),getdate(),111),
 convert(varchar(8),getdate(),8),@signaddr)
 }
 */
#pragma mark -定位
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"%@",userLocation.location);
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            for (CLPlacemark *placemark in placemarks) {
                //详细信息
                NSLog(@"详细信息:%@", placemark.addressDictionary);
                NSLog(@"%@",placemark.name);
                userLocation.title = placemark.name;
                //取placemarks里面的最后一个定位值
                
            }
        }
    }];
}
#pragma mark -确定签到
- (IBAction)LocatedAndWriteButton:(UIButton *)sender {
    //点击确定签到
    NSLog(@"点击确定签到");
}



/*
 任务: 1 -> 上传
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
