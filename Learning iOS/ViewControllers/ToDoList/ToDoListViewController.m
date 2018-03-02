//
//  ToDoListViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/1/31.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "ToDoListViewController.h"
#import "SecondViewController.h"
#import "taskListModal.h"
#import "SignleInstance.h"

@interface ToDoListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * mainTable;
@property (nonatomic,strong) NSArray * tableList;

@end

@implementation ToDoListViewController

-(NSArray *)tableList {
    // taskListModal * modal = [[taskListModal alloc] init];
    // [SignleInstance sharedInstance].taskArr = [[NSArray alloc]initWithObjects:modal, nil];
    if (!_tableList) {
        taskListModal * modal = [[taskListModal alloc] init];
        [SignleInstance sharedInstance].taskArr = [[NSArray alloc]initWithObjects:modal, nil];
    }
    _tableList = [SignleInstance sharedInstance].taskArr;
    return _tableList;
}
-(UITableView *) mainTable {
    if(!_mainTable){
        _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    }
    return  _mainTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ToDoList";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addItem)];
    [self.view addSubview:self.mainTable];
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated{
    if(self.tableList.count){
        [self.mainTable reloadData];
    }
}

- (void) addItem{
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma UITableViewDelagate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    secondVC.selectedModal = [SignleInstance sharedInstance].taskArr[indexPath.row];
    [self.navigationController pushViewController:secondVC animated:YES];
}

#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.tableList.count == 0){
        return 0;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if(section == 0){
    //        return 100;
    //    }else if(section == 1){
    //        return 20;
    //    }else {
    //        return 5;
    //    }
    if(self.tableList.count == 0){
        return 0;
    } else {
        return self.tableList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *myCell = @"myCell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:myCell];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
    }
    //    taskListModal *modal = [[taskListModal alloc] init];
    //    NSArray *list = modal.myTaskList;
    
    NSArray *list = self.tableList;
    
    // NSLog(@"indexPath is %ld",indexPath.row);
    //    cell.textLabel.text = [NSString stringWithFormat:@"section:%d row: %d",indexPath.section+1,indexPath.row+1];
    taskListModal *model = list[indexPath.row];
    cell.textLabel.text = model.taskStr;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [tableView beginUpdates];
        NSMutableArray * oldArr = [[NSMutableArray alloc]initWithArray:[SignleInstance sharedInstance].taskArr];
        // NSMutableArray * indexPathArray = [NSMutableArray arrayWithObject:indexPath];
        //        NSLog(@"点击了删除");
        
        [oldArr removeObjectAtIndex:indexPath.row];
        [SignleInstance sharedInstance].taskArr = oldArr;
        self.tableList = oldArr;
        if(self.tableList.count == 0){
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
        }else{
            NSArray* indexPaths = @[indexPath] ;
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        }
        [tableView reloadData];
        [tableView endUpdates];
        
    }];
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        SecondViewController *secondVC = [[SecondViewController alloc]init];
        secondVC.selectedModal = [SignleInstance sharedInstance].taskArr[indexPath.row];
        [self.navigationController pushViewController:secondVC animated:YES];
        //        NSLog(@"点击了编辑");
    }];
    editAction.backgroundColor = [UIColor grayColor];
    return @[deleteAction, editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    editingStyle = UITableViewCellEditingStyleDelete;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
