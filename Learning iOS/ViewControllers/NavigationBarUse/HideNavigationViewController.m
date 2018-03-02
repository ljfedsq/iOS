//
//  ScaleViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/28.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "HideNavigationViewController.h"

@interface HideNavigationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView * tableView;
@end

@implementation HideNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"CELL";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [self randomColor];
    
    return cell;
}


#pragma mark - 滑动隐藏导航栏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + _tableView.contentInset.top;//注意
    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:self.tableView].y;
    
    if (offsetY > 64) {
        if (panTranslationY > 0) { //下滑趋势，显示
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
        else {  //上滑趋势，隐藏
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    
    //    NSLog(@"%lf %lf", [scrollView.panGestureRecognizer translationInView:self.tableView].y, offsetY);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1];
}


@end
