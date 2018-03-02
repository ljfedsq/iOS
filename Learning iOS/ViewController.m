//
//  ViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/1/31.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * fullTable;
@property (nonatomic,strong) NSArray * exampleArr;
@property (nonatomic,strong) NSArray * exampleControllers;

@end

@implementation ViewController

-(UITableView *) fullTable{
    if(!_fullTable){
        _fullTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)style:UITableViewStylePlain];
    }
    return _fullTable;
}

-(NSArray *) exampleControllers {
    if(!_exampleControllers){
        ToDoListViewController * todoListControl = [[ToDoListViewController alloc]init];
        CityPickerViewController * cityPickerControl = [[CityPickerViewController alloc]init];
        LoginViewController * loginControl = [[LoginViewController alloc]init];
        WindLoginViewController * windLoginControl = [[WindLoginViewController alloc]init];
        NavigationBarUseViewController * naviBarControl = [[NavigationBarUseViewController alloc]init];
        TimeDownBtnViewController * timeDownBtnControl = [[TimeDownBtnViewController alloc]init];
        _exampleControllers = @[todoListControl,cityPickerControl,loginControl,windLoginControl,naviBarControl,timeDownBtnControl];
    }
    return  _exampleControllers;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOS Examples";
    [self.view addSubview: self.fullTable];
    self.fullTable.delegate = self;
    self.fullTable.dataSource = self;
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"utils" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    self.exampleArr = dict[@"examples"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.exampleArr.count == 0){
        return 0;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.exampleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * exampleCell = @"exampleCell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:exampleCell];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:exampleCell];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exampleCell];
    }
    cell.textLabel.text = self.exampleArr[indexPath.row];
    return cell;
}

#pragma UITableViewDelagate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:self.exampleControllers[indexPath.row] animated:YES];
//    if(indexPath.row==4){
//        [self presentViewController:self.exampleControllers[indexPath.row]  animated:YES completion:nil];
//    }else{
//        [self.navigationController pushViewController:self.exampleControllers[indexPath.row] animated:YES];
//    }
    
//    if (indexPath.row == 0) {
//        ToDoListViewController *todoListVC = [[ToDoListViewController alloc] init];
//        [self.navigationController pushViewController:todoListVC animated:YES];
//    } else if(indexPath.row == 1){
//        CityPickerViewController *cityPickerVC = [[CityPickerViewController alloc] init];
//        [self.navigationController pushViewController:cityPickerVC animated:YES];
//    }else if(indexPath.row == 2){
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        [self.navigationController pushViewController:loginVC animated:YES];
//    }
}

@end
