//
//  LoginSuccessViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/1.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "LoginSuccessViewController.h"

@interface LoginSuccessViewController ()
@property (strong,nonatomic) UILabel *userNameLabel;
@property (strong,nonatomic) UIImageView * userPhoto;

@end

@implementation LoginSuccessViewController

-(UILabel *)userNameLabel {
    if(!_userNameLabel){
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(140, 100, 150, 40)];
        _userNameLabel.textColor = [UIColor blueColor];
        _userNameLabel.text =[[NSString alloc]initWithFormat:@"Hello:%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]];
        _userNameLabel.backgroundColor = [UIColor yellowColor];
    }
    return _userNameLabel;
}

-(UIImageView *)userPhoto {
    if(!_userPhoto){
        NSData * photoData =[[NSUserDefaults standardUserDefaults]objectForKey:@"userPhoto"] ;
        _userPhoto = [[UIImageView alloc]initWithFrame:CGRectMake(30, 80, 80, 80)];
        _userPhoto.layer.cornerRadius = 40;
        _userPhoto.layer.masksToBounds = true;
        _userPhoto.image = [UIImage imageWithData:photoData];
    }
    return _userPhoto;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFrame];
}

-(void)initFrame {
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.userPhoto];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
