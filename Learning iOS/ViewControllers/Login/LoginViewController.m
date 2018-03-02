//
//  LoginViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/1.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginSuccessViewController.h"
#import "CommonViewController.h"

# define NUMBERS @"0123456789\n"
# define kAlphaNum @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\n"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFrame];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUserPhoto];
    NSString *nameData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *passwordData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    if(nameData!=nil){
        self.userNameTextField.text = nameData;
    }
    if(passwordData!=nil){
        self.passwordTextField.text = passwordData;
    }
}

- (void)initFrame {
    self.title = @"Login";
    self.userPhoto.layer.cornerRadius = 40;
    self.userPhoto.layer.masksToBounds = true;
    self.userPhoto.layer.borderColor = [UIColor blueColor].CGColor;
    self.userPhoto.layer.borderWidth = 1;
    self.userPhoto.image = [UIImage imageNamed:@"header1.jpg"];
    self.userNameTextField.placeholder = @"请输入用户名";
    self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userNameTextField.delegate = self;
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.delegate = self;
    self.loginBtn.backgroundColor = [UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1];
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = true;
    self.registerBtn.backgroundColor = [UIColor colorWithRed:138/255.0 green:43/255.0 blue:226/255.0 alpha:1];
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = true;
}

- (IBAction)action:(id)sender {
    if([self validateInfo]){
        LoginSuccessViewController * successVC = [[LoginSuccessViewController alloc] init];
        [self.navigationController pushViewController:successVC animated:YES];
    }else if(self.userNameTextField.text.length==0||self.passwordTextField.text.length==0){
        UIAlertController * errorAlert = [[[CommonViewController alloc]init] AlertView:@"提示" :@"用户名或密码不能为空"];
        [self presentViewController: errorAlert animated:YES completion:nil];
    }else{
        UIAlertController * errorAlert = [[[CommonViewController alloc]init] AlertView:@"提示" :@"用户名或密码错误"];
        [self presentViewController: errorAlert animated:YES completion:nil];
    }
}

- (IBAction)goToRegister:(id)sender {
    RegisterViewController * registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
    //[self presentViewController:registerVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initUserPhoto{
    self.userPhoto.image = [UIImage imageNamed:@"header1.jpg"];
}

-(void)updateUserPhoto{
    NSData *photoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhoto"];
    if(photoData!=nil){
        self.userPhoto.image = [UIImage imageWithData:photoData];
    }
}

-(BOOL)validateInfo{
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    if(name == self.userNameTextField.text && password == self.passwordTextField.text){
        return YES;
    }else{
        return NO;
    }
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

//限制输入字母和数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum]invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    if(!canChange){
        UIAlertController * alertController = [[[CommonViewController alloc]init] AlertView:@"提示" :@"请输入字母和数字"];
        [self presentViewController: alertController animated:YES completion:nil];
        return NO;
    }
    return canChange;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if([self validateInfo]){
        [self updateUserPhoto];
    }else{
        [self initUserPhoto];
    }
}
@end
