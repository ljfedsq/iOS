//
//  SecondViewController.m
//  ToDoList
//
//  Created by MinBaby on 2018/1/25.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "SecondViewController.h"
#import "taskListModal.h"
#import "SignleInstance.h"


@interface SecondViewController ()
@property (strong,nonatomic) UITextField *myTextField;

@end

@implementation SecondViewController

-(UITextField *) myTextField{
    if(!_myTextField){
        _myTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 100, 250, 40)];
        _myTextField.textColor = [UIColor blackColor];
        _myTextField.backgroundColor = [UIColor whiteColor];
        _myTextField.borderStyle = UITextBorderStyleLine;
        if(self.selectedModal){
            _myTextField.text = self.selectedModal.taskStr;
        }
    }
    return _myTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(saveItem)];
    
    
    [self.view addSubview:self.myTextField];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveItem {
    if(self.selectedModal){
        NSArray * oldArr =[SignleInstance sharedInstance].taskArr ;
        for (taskListModal * modal in oldArr) {
            if([modal.taskId isEqualToString:self.selectedModal.taskId]){
                modal.taskStr = self.myTextField.text;
            }
        }
        [SignleInstance sharedInstance].taskArr = oldArr;
    }else{
        taskListModal *modal = [[taskListModal alloc] init];
        modal.taskStr = self.myTextField.text;
        NSArray * oldArr =[SignleInstance sharedInstance].taskArr ;
        modal.taskId =[ [NSString alloc]initWithFormat:@"%ld",oldArr.count];
        NSMutableArray * newArr = [[NSMutableArray alloc]initWithArray: [SignleInstance sharedInstance].taskArr];
        [newArr addObject:modal];
        [SignleInstance sharedInstance].taskArr = newArr;
    }
    [self.navigationController popViewControllerAnimated:YES];
    //[modal addTask:self.myTextField.text];
}


@end
