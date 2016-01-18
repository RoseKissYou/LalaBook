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

- (IBAction)back2CheckVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"%@",userLocation.location);
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            for (CLPlacemark *placemark in placemarks) {
                //详细信息
                NSLog(@"详细信息:%@", placemark.addressDictionary);
                NSLog(@"%@",placemark.name);
                userLocation.title = placemark.name;
            }
        }
    }];
}
// 任务: 1 -> 上传
#pragma mark - 上传位置信息到服务器

/*


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
