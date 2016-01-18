//
//  AAAMngViewController.m
//  BaseProject
//
//  Created by 小笨熊 on 16/1/6.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAAMngViewController.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"
#import "AAAWeatherCell.h"

//
#import "AAAWeather.h"
#import "AAAWeatherDataRequestTool.h"

#import "AAALocationStr.h"
#import <AVFoundation/AVFoundation.h>

/**
 *  openID:JH6096caaeacc0fe40b7b080028fc82185
 *  appKey:
 */


@interface AAAMngViewController ()<AVSpeechSynthesizerDelegate>

@property (strong,nonatomic) AAAWeather *weather;


@property (weak,nonatomic) AAAWeatherCell *cell;
//语音合成对象
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
//播报的语音内容
@property (strong, nonatomic) NSString *notiWeathVoice;



@end

@implementation AAAMngViewController
- (AVSpeechSynthesizer *)synthesizer
{
    if (!_synthesizer) {
        _synthesizer = [AVSpeechSynthesizer new];
        _synthesizer.delegate = self;
    }return _synthesizer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置管家视图
    [self voiceHello];
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH6096caaeacc0fe40b7b080028fc82185"];
    //请求天气数据
    [[AAAWeatherDataRequestTool sharedAAAWeatherDataRequestTool] requestWeatherDataWithcityName:[AAALocationStr sharedAAALocationStr].locationStr_cn Success:^(AAAWeather *weather) {
        self.weather = weather;
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
//语音
- (void)voiceHello{
    NSLog(@"说话内容");
    //说话内容
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"主人 您好"];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"]; //设置语言
    [self.synthesizer speakUtterance:utterance]; //开始说话
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AAAWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherCell" forIndexPath:indexPath];
    self.cell = cell;
    // Configure the cell...
    //改变拉拉的位置
    
    [UIView animateWithDuration:1.0f animations:^{
        [cell changeLalaPosition];
        [cell layoutIfNeeded];
    }];
    //today取用数据: 城市city 天气weather 穿衣指导dressing_index 洗车指导wash_index 旅行指数travel_index 运动指数exercise_index
    NSLog(@"今天%@天气是%@,穿衣%@,%@运动,%@旅行,%@洗车",self.weather.today.city,self.weather.today.weather,self.weather.today.dressing_advice,self.weather.today.travel_index,self.weather.today.exercise_index,self.weather.today.wash_index);
    
   NSString *weatherNoti =  [cell setWeatherForCity:self.weather.today.city andWeather:self.weather.today.weather andDressing:self.weather.today.dressing_advice andTravel:self.weather.today.travel_index andExercise:self.weather.today.exercise_index andWashCar:self.weather.today.wash_index];
    self.notiWeathVoice = weatherNoti;
    [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(changeView) userInfo:nil repeats:YES];
   
    [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(readWeather) userInfo:nil repeats:NO];
    
    return cell;
}

//changview
- (void)changeView{
    
    [self.cell showWeatherView];  //显示天气数据
}
- (void)readWeather
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.notiWeathVoice];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"]; //设置语言
    [self.synthesizer speakUtterance:utterance]; //开始说话

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
