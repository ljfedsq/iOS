//
//  RegisterViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/1.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImage;
@property (weak, nonatomic) IBOutlet UITextField *registerUserNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmRegisterBtn;

@property BOOL isAddPhoto;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFrame];
}

- (void)initFrame{
    self.title = @"Register";
    self.userPhotoImage.layer.cornerRadius = self.userPhotoImage.frame.size.width/2;
    self.userPhotoImage.layer.masksToBounds = YES;
    self.userPhotoImage.layer.borderColor = [UIColor blueColor].CGColor;
    self.userPhotoImage.layer.borderWidth = 1;
    self.userPhotoImage.image = [UIImage imageNamed:@"default_photo.jpg"];
    self.isAddPhoto = NO;
    self.userPhotoImage.userInteractionEnabled = YES;
    //初始化手势
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alertHeadProtrait:)];
    [self.userPhotoImage addGestureRecognizer:singleTap];
    
    self.registerUserNameTextField.placeholder = @"请输入用户名";
    self.registerUserNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.registerUserNameTextField.delegate = self;
    self.firstPasswordTextField.placeholder = @"请输入密码";
    self.firstPasswordTextField.secureTextEntry = YES;
    self.firstPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.firstPasswordTextField.delegate = self;
    self.confirmPasswordTextField.placeholder = @"请确认密码";
    self.confirmPasswordTextField.secureTextEntry = YES;
    self.confirmPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirmPasswordTextField.delegate = self;
    
    self.confirmRegisterBtn.backgroundColor = [UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1];
    self.confirmRegisterBtn.layer.cornerRadius = 5;
    self.confirmRegisterBtn.layer.masksToBounds = true;
  
}
- (IBAction)clickConfirmPassword:(id)sender {
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//当keyboard的frame开始发生变化时触发
-(void)keyboardDidChangeFrame:(NSNotification *)notification{
    CGRect kbFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat tranY = (kbFrame.origin.y == [UIScreen mainScreen].bounds.size.height)?0:-150;
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, tranY);
    }];
}

- (void)alertHeadProtrait:(UITapGestureRecognizer *) gesture{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *
        _Nonnull action) {
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"  style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:UIImagePickerControllerEditedImage];
    if(newPhoto != nil){
        NSData *imageData ;
        if(UIImagePNGRepresentation(newPhoto)){
            imageData = UIImagePNGRepresentation(newPhoto);
        }else {
            imageData = UIImageJPEGRepresentation(newPhoto, 1.0);
        }
        [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"userPhoto"];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.userPhotoImage.image = newPhoto;
        self.isAddPhoto = YES;
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)clickRegister:(id)sender {
    NSString * message = @"";
    BOOL isValidate = YES;
    if(self.registerUserNameTextField.text.length == 0 ||
       self.firstPasswordTextField.text.length == 0||
       self.confirmPasswordTextField.text.length == 0){
        message = @"输入框不能为空！";
        isValidate = NO;
    }else if(self.firstPasswordTextField.text!=self.confirmPasswordTextField.text){
        message = @"两次输入的密码不相同";
        isValidate = NO;
    }else if(!self.isAddPhoto){
        message = @"未设置头像";
        isValidate = NO;
    }
    if(isValidate){
        //返回后执行的事件；
        [[NSUserDefaults standardUserDefaults]setObject:self.registerUserNameTextField.text forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults]setObject:self.firstPasswordTextField.text forKey:@"userPassword"];
        [self.navigationController popViewControllerAnimated:YES];
        //[self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertController * validateAlertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [validateAlertControl dismissViewControllerAnimated:YES completion:nil];
        }];
        [validateAlertControl addAction:okAction];
        [self presentViewController:validateAlertControl animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.registerUserNameTextField resignFirstResponder];//失去焦点
    [self.firstPasswordTextField resignFirstResponder];
    [self.confirmPasswordTextField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];//取消监听
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.registerUserNameTextField resignFirstResponder];//return后收起键盘
    [self.firstPasswordTextField resignFirstResponder];
    [self.confirmPasswordTextField resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];//取消监听
    return YES;
}


@end
