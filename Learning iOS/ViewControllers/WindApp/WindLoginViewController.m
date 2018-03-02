//
//  WindLoginViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/5.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "WindLoginViewController.h"
#import "ChooseProduceView.h"
#import "CommonViewController.h"
#import "AESCrypt.h"
#import "WindAppServices.h"
#import "HomePageViewController.h"

@interface WindLoginViewController ()<UITextFieldDelegate,ChooseProduceViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *environmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberOfPanelTextField;

@end

@implementation WindLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFrame];
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

-(void)initFrame {
    [self.userNameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.passwordTextField.secureTextEntry = YES;
    // 给选择环境label添加点击事件
    UITapGestureRecognizer *environmentLabelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSelectEnvironmentLabel)];
    [self.environmentLabel addGestureRecognizer:environmentLabelTapGestureRecognizer];
    self.environmentLabel.userInteractionEnabled = YES;
    // 给选择类型label添加点击事件
    UITapGestureRecognizer *typeLabelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSelectTypeLabel)];
    [self.typeLabel addGestureRecognizer:typeLabelTapGestureRecognizer];
    self.typeLabel.userInteractionEnabled = YES;
    [self.numberOfPanelTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}

-(void)clickSelectEnvironmentLabel{
    [[NSUserDefaults standardUserDefaults]setObject:@"ip" forKey:@"viewType"];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChooseProduceView" owner:nil options:nil];
    ChooseProduceView *chooseView = (ChooseProduceView *)[array objectAtIndex:0];
    NSInteger X = (self.view.frame.size.width-chooseView.frame.size.width)/2;
    NSInteger Y = (self.view.frame.size.height-chooseView.frame.size.width)/2;
    chooseView.frame = CGRectMake(X, Y, chooseView.frame.size.width,chooseView.frame.size.height);
    chooseView.mdelegate = self;
    [chooseView setAlpha:0];
    [self.view addSubview:chooseView];
    [UIView animateWithDuration:0.5 animations:^{
        [chooseView setAlpha:1.0];
    } completion:^(BOOL finished) {
    }];
}

-(void)clickSelectTypeLabel {
    [[NSUserDefaults standardUserDefaults]setObject:@"customer" forKey:@"viewType"];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChooseProduceView" owner:nil options:nil];
    ChooseProduceView *chooseView = (ChooseProduceView *)[array objectAtIndex:0];
    chooseView.viewType = @"customer";
    NSInteger x = (self.view.frame.size.width - chooseView.frame.size.width)/2;
    NSInteger Y = (self.view.frame.size.height - chooseView.frame.size.height)/2;
    chooseView.frame = CGRectMake(x, Y, chooseView.frame.size.width, chooseView.frame.size.height);
    chooseView.mdelegate = self;
    [chooseView setAlpha:0];
    [self.view addSubview:chooseView];
    
    [UIView animateWithDuration:0.5 animations:^{
        [chooseView setAlpha:1.0];
    }completion:^(BOOL finished){
    }];
}

-(void)setEnvironmentLabel{
    NSString *type = [[NSUserDefaults standardUserDefaults]valueForKey:IPTYPE];
    if(![type stringIsValid]){
        type = ProductionCH;
    }
    ServiceType intType = (ServiceType)[type integerValue];
    switch(intType){
        case ProductionCH:
        {
            [self.environmentLabel setText:NSLocalizedString(@"China", nil)];
            break;
        }
        case ProductionEN:
        {
            [self.environmentLabel setText:NSLocalizedString(@"International", nil)];
            break;
        }
        case Custom:
        {
            [self.environmentLabel setText:NSLocalizedString(@"Custom Environment", nil)];
            break;
        }
        default:
        break;
    }
}

-(void)setTypeLabel{
    NSString *type = [[NSUserDefaults standardUserDefaults]valueForKey:CUSTOMERTYPE];
    if(![type stringIsValid]){
        type = Default;
    }
    ServiceType intType = (ServiceType)[type integerValue];
    switch(intType){
        case Default:
        {
            [self.typeLabel setText:NSLocalizedString(@"Default", nil)];
            break;
        }
        case Rollout:
        {
            [self.typeLabel setText:NSLocalizedString(@"Envision Protal", nil)];
            break;
        }
        default:
        break;
    }
}

- (IBAction)clickLoginBtn:(id)sender {
    NSString * message = @"";
    NSString * acountStr = self.userNameTextField.text;
    NSString * passwordStr = self.passwordTextField.text;
    BOOL isValidate = YES;
    HomePageViewController * homeVC = [[HomePageViewController alloc]init];
    homeVC.numberOfPanel = self.numberOfPanelTextField.text;
    if(acountStr.length == 0 || passwordStr.length == 0){
        message = @"输入框不能为空！";
        isValidate = NO;
    }
    if(isValidate){
       //[self.view setHidden:YES];
        //密码加密
        NSString *passwordEncode = [AESCrypt encyptaes128:passwordStr];
        NSString *domainCode = [self.typeLabel.text isEqualToString:@"Default"] ? @"default" : @"RCC";
        WindAppServices * services = [[WindAppServices alloc]init];
        [services onLoginServicesWithUser:acountStr AndPsd:passwordEncode AndDomainCode:domainCode blockWithSucces:^(NSArray *dataArray) {
            //UIAlertController * errorAlert = [[[CommonViewController alloc]init] AlertView:@"提示" :@"登录成功！"];
            // [self presentViewController: errorAlert animated:YES completion:nil];
             [self.navigationController pushViewController:homeVC animated:YES];
            //[self presentViewController:homeVC animated:YES completion:nil];
        } failure:^(NSString *error) {
            UIAlertController * errorAlert = [[[CommonViewController alloc]init] AlertView:@"提示" :error];
            [self presentViewController: errorAlert animated:YES completion:nil];
        }];
    }else{
        UIAlertController * errorAlert = [[[CommonViewController alloc]init] AlertView:@"提示" :message];
        [self presentViewController: errorAlert animated:YES completion:nil];
    }
}

- (IBAction)clickSelectEnvironmentBtn:(id)sender {
    [self clickSelectEnvironmentLabel];
}

- (IBAction)clickSelectTypeBtn:(id)sender {
    [self clickSelectTypeLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.userNameTextField resignFirstResponder];//失去焦点
    [self.passwordTextField resignFirstResponder];
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.userNameTextField resignFirstResponder];//return后收起键盘
    [self.passwordTextField resignFirstResponder];
    return YES;
}

#pragma ChooseProduceViewDelegate
-(void)valueChange
{
    [self setEnvironmentLabel];
    [self setTypeLabel];
}

-(void)settingViewShow
{
    
}


@end
