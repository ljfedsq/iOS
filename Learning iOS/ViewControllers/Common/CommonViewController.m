//
//  CommonViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/5.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 错误提示框显示
-(UIAlertController *)AlertView : (NSString *) title :(NSString *)message {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:NO completion:nil];
    }];
    [alertController addAction:okAction];
    return alertController;
}
@end
