//
//  AAAHouseTableViewController.m
//  N+
//
//  Created by hy2 on 16/1/14.
//  Copyright © 2016年 Jake_Smith. All rights reserved.
//

#import "AAAHouseTableViewController.h"
#import "HouseHeader.h"

static NSInteger lalaToSmall  = 50;
@interface AAAHouseTableViewController ()<AVSpeechSynthesizerDelegate>
//拉拉动画view
@property (weak, nonatomic) IBOutlet UIImageView *lalaAnimationView;
//拉拉所在view四周布局
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lalaViewTopLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lalaViewRightLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lalaViewBottomLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lalaViewLeftLayout;

//拉拉衣服图片
@property (weak, nonatomic) IBOutlet UIImageView *lalaClothImageView;
//天气文字显示视图
@property (weak, nonatomic) IBOutlet UIView *showTheWeatherView;
//天气显示label
@property (weak, nonatomic) IBOutlet UILabel *showTheWeatherLabel;
//天气接收模型
@property (strong,nonatomic) AAAWeather *weather;
//SK数据显示
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *windStrengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *windDirectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentHumidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateTimeLabel;

//语音合成对象
@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;
//播报的语音内容
@property (strong, nonatomic) NSString *notiWeathVoice;

@end

@implementation AAAHouseTableViewController
- (AVSpeechSynthesizer *)synthesizer
{
    if (!_synthesizer) {
        _synthesizer = [AVSpeechSynthesizer new];
        _synthesizer.delegate = self;
    }return _synthesizer;
}
- (UILabel *)showTheWeatherLabel
{
    if (!_showTheWeatherLabel) {
        _showTheWeatherLabel.text = @"天气数据正在更新,请稍后";
    }return _showTheWeatherLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"AAATodayCell" bundle:nil ] forCellReuseIdentifier:@"todayCell"];
    //隐藏天气显示view
    self.showTheWeatherView.hidden = YES;
    //获取天气数据
    [self requestWeatherData];
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark- 获取天气数据
- (void)requestWeatherData
{
    
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:weatherJuheOpenID];
    //请求天气数据
    [[AAAWeatherDataRequestTool sharedAAAWeatherDataRequestTool] requestWeatherDataWithcityName:@"佛山" Success:^(AAAWeather *weather) {
        self.weather = weather;
        //view界面显示天气数据 SK数据显示
        [self updateSKWeather:weather];
        
        //刷新显示tableView
        [self.tableView reloadData];
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
//更新首页SK天气数据
- (void)updateSKWeather:(AAAWeather *)weather
{
    //今日平均温度
    self.tempLabel.text = [NSString stringWithFormat:@"%@˚C",weather.sk.temp];
    self.windStrengthLabel.text = weather.sk.wind_strength;
    self.windDirectionLabel.text = weather.sk.wind_direction;
    self.currentHumidityLabel.text = weather.sk.humidity;
    self.lastUpdateTimeLabel.text = [NSString stringWithFormat:@"今天%@更新",weather.sk.time];
}
#pragma mark- 语音
- (void)voiceHello{
    NSLog(@"说话内容");
    //说话内容
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"主人 您好"];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"]; //设置语言
    [self.synthesizer speakUtterance:utterance]; //开始说话
}
- (IBAction)touchLalaButton:(UIButton *)sender {
    NSLog(@"点击了拉拉");
    //0. 语音问候 "主人 您好"
    [self voiceHello];
    // 1, 拉拉所在视图缩小
    [UIView animateWithDuration:2.5f animations:^{
        self.lalaViewTopLayout.constant = lalaToSmall * 2;
        self.lalaViewRightLayout.constant = lalaToSmall;
        self.lalaViewLeftLayout.constant = lalaToSmall;
    }];
    self.showTheWeatherView.hidden = NO;
    //显示今天天气数据
    //NSString *weatherNoti =  [cell setWeatherForCity:self.weather.today.city andWeather:self.weather.today.weather andDressing:self.weather.today.dressing_advice andTravel:self.weather.today.travel_index andExercise:self.weather.today.exercise_index andWashCar:self.weather.today.wash_index];
    NSString *weatherNoti = [NSString stringWithFormat:@"今天%@天气是%@,穿衣%@%@运动,%@旅行,%@洗车",self.weather.today.city,self.weather.today.weather,self.weather.today.dressing_advice,self.weather.today.travel_index,self.weather.today.exercise_index,self.weather.today.wash_index];
    self.showTheWeatherLabel.text = weatherNoti;
    [self readWeather];
    
}
- (void)readWeather
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.showTheWeatherLabel.text];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"]; //设置语言
    [self.synthesizer speakUtterance:utterance]; //开始说话
    
}
- (void)showWeatherView
{
    //延时2.5秒后开始调用天气显示视图
  //  [NSThread sleepForTimeInterval:2.5f];
    //2.上方出现今日天气概况, 并开始朗读

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
     AAATodayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todayCell"];

    if (indexPath.row == 0) {
        cell.todayTemperatureLabel.text = [NSString stringWithFormat:@"温度浮动区间:%@",self.weather.today.temperature];
        cell.todayWeatherDescripeLabel.text =  [NSString stringWithFormat:@"今日天气:%@",self.weather.today.weather];
        cell.todayUVIndexLabel.text = [NSString stringWithFormat:@"紫外线强度:%@",self.weather.today.uv_index];
        cell.todayDressAdviceLabel.text = [NSString stringWithFormat:@"穿衣%@",self.weather.today.dressing_advice];
    }else
    {
        
    }
   
    // Configure the cell...
  
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
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
