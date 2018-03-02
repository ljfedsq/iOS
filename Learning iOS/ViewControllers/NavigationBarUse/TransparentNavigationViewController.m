//
//  NavigationViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/28.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "TransparentNavigationViewController.h"

@interface TransparentNavigationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIImageView * topImageView;
@property (nonatomic, assign) CGFloat topContentInset;
@property (nonatomic, assign) CGFloat alphaMemory;
@property (nonatomic, assign) BOOL statusBarStyleControl;

@end

@implementation TransparentNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _statusBarStyleControl = NO;

    [self.view addSubview:self.tableView];
    [self createScaleImageView];
    [self createHeadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScaleImageView
{
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*435.5/414.0)];
    _topImageView.backgroundColor = [UIColor whiteColor];
    _topImageView.image = [UIImage imageNamed:@"backImage"];
    [self.view insertSubview:_topImageView belowSubview:_tableView];
}

#pragma mark - 创建头像视图
- (void)createHeadView
{
    _topContentInset = 136; //136+64=200
    
    UIView * headBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _topContentInset)];
    headBkView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headBkView;
    
    UIImageView * _headImageView = [[UIImageView alloc] init];
    _headImageView.bounds = CGRectMake(0, 0, 64, 64);
    _headImageView.center = CGPointMake(SCREEN_WIDTH/2., (_topContentInset - 64)/2.);
    _headImageView.backgroundColor = [UIColor whiteColor];
    _headImageView.layer.cornerRadius = _headImageView.bounds.size.width / 2.;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.image = [UIImage imageNamed:@"header2.jpg"];
    [headBkView addSubview:_headImageView];
}

#pragma mark - 创建tableView
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(64 + _topContentInset, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64 + _topContentInset, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _tableView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - 滑动代理
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y + _tableView.contentInset.top;
    if(offsetY > _topContentInset && offsetY <= _topContentInset * 2){
        _statusBarStyleControl = YES;
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
        self.navigationController.navigationBar.tintColor = [UIColor blackColor];
        
        _alphaMemory = offsetY/(_topContentInset * 2) >= 1 ? 1 : offsetY/(_topContentInset * 2);
        
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:_alphaMemory];
        
    }
    else if (offsetY <= _topContentInset) {
        _statusBarStyleControl = NO;
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            [self setNeedsStatusBarAppearanceUpdate];
        }
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        _alphaMemory = 0;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    }
    else if (offsetY > _topContentInset * 2) {
        _alphaMemory = 1;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    }
    
    if (offsetY < 0) {
        _topImageView.transform = CGAffineTransformMakeScale(1 + offsetY/(-500), 1 + offsetY/(-500));
    }
    CGRect frame = _topImageView.frame;
    frame.origin.y = 0;
    _topImageView.frame = frame;
    
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

- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    
    return [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:1];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (_statusBarStyleControl) {
        return UIStatusBarStyleDefault;
    }
    else {
        return UIStatusBarStyleLightContent;
    }
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
