//
//  TimeDownBtnViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/3/1.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "TimeDownBtnViewController.h"
#define SECONDS 60;

@interface TimeDownBtnViewController ()
@property (nonatomic,strong) UIButton * timeButton;
@property (nonatomic,strong) NSTimer * timer;

@end

@implementation TimeDownBtnViewController{
    NSInteger _time;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _time = SECONDS;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.timeButton];
    [self refreshButtonWidth];
}

-(UIButton *)timeButton{
    if(!_timeButton){
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_timeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _timeButton.enabled = YES;
    }
    return _timeButton;
}

-(void)refreshButtonWidth{
    CGFloat width = 0;
    if(_timeButton.enabled){
        width = 80;
    }else{
        width = 120;
    }
    _timeButton.center = CGPointMake(SCREEN_WIDTH/2, 150);
    _timeButton.bounds = CGRectMake(0, 0, width, 40);
    [_timeButton setBackgroundImage:[self imageWithColor:[UIColor orangeColor] andSize:_timeButton.frame.size] forState:UIControlStateNormal];
    [_timeButton setBackgroundImage:[self imageWithColor:[UIColor lightGrayColor] andSize:_timeButton.frame.size] forState:UIControlStateDisabled];
}

- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)aSize
{
    CGRect rect = CGRectMake(0.0f, 0.0f, aSize.width, aSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


-(void)btnAction:(UIButton *)sender{
    _timeButton.enabled = NO;
    [self refreshButtonWidth];
    [_timeButton setTitle:[NSString stringWithFormat:@"获取验证码(%zi)",_time] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
}

-(void)timeDown{
    _time --;
    if(_time == 0){
        [_timeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        _timeButton.enabled = YES;
        [self refreshButtonWidth];
        [_timer invalidate];
        _timer = nil;
        _time = SECONDS;
        return;
    }
    [_timeButton setTitle:[NSString stringWithFormat:@"获取验证码(%zi)",_time] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
