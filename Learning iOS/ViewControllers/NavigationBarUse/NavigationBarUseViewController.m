//
//  NavigationBarUseViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/28.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "NavigationBarUseViewController.h"
#import "TransparentNavigationViewController.h"
#import "HideNavigationViewController.h"

@interface NavigationBarUseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) UIImageView * topImageView;
@property (nonatomic,assign) CGFloat * recceiveAlpha;
@property (nonatomic,strong) UINavigationBar * navigationBar;

@end

@implementation NavigationBarUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.navigationController.navigationBarHidden = YES;
    //[self.view addSubview:self.navigationBar];
    
    //self.navigationItem.titleView = self.topImageView;
    [self createScaleHeadView];
    [self.view addSubview:self.tableView];
    self.navigationItem.leftBarButtonItem.title = @"Back";
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(goHideNavigationPage:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    //UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"<Back" style:UIBarButtonItemStyleDone target:self action:@selector(goHidePage:)];
    //self.navigationItem.leftBarButtonItem = leftBtn;
    //[self.view addSubview:self.topImageView];
}
-(void)goTransparentPage:(UIBarButtonItem *)btn{
    TransparentNavigationViewController * transparentVC = [[TransparentNavigationViewController alloc]init];
    [self.navigationController pushViewController:transparentVC animated:YES];
}

-(void)goHideNavigationPage:(UIBarButtonItem *)btn{
    HideNavigationViewController * hideNavigationVC = [[HideNavigationViewController alloc]init];
    [self.navigationController pushViewController:hideNavigationVC animated:YES];
}

-(UINavigationBar *) navigationBar {
    if(!_navigationBar){
        _navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
        _navigationBar.backgroundColor = [UIColor greenColor];
        //[_navigationBar setTitleVerticalPositionAdjustment:10 forBarMetrics:UIBarMetricsDefault];
        UINavigationItem *item = [[UINavigationItem alloc]initWithTitle:@"使用nav"];
        //item.titleView = self.topImageView;
        [_navigationBar pushNavigationItem:item animated:YES];
    }
    return _navigationBar;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

//-(UIImageView *) topImageView{
//    UIView * topBkView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 78, 44)];
//    topBkView.backgroundColor = [UIColor clearColor];
//    if(!_topImageView){
//        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2.0 - 20, 44, 40, 40)];
//        _topImageView.backgroundColor = [UIColor whiteColor];
//        _topImageView.layer.cornerRadius = _topImageView.bounds.size.width /2;
//        _topImageView.layer.masksToBounds = YES;
//        //_topImageView.center = CGPointMake(SCREEN_WIDTH / 2, 64);
//        _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
//        //_topImageView.image = [UIImage imageNamed:@"header1.jpg"];
//    }
//    return _topImageView;
//}

- (void)createScaleHeadView
{
    UIView * topBkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 78, 44)];
    topBkView.backgroundColor = [UIColor clearColor];
    
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 78, 78)];
    _topImageView.backgroundColor = [UIColor whiteColor];
    _topImageView.layer.cornerRadius = _topImageView.bounds.size.width / 2.;
    _topImageView.layer.masksToBounds = YES;
    _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _topImageView.image = [UIImage imageNamed:@"header1.jpg"];
    [topBkView addSubview:_topImageView];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goTransparentPage:)];//添加手势
    [topBkView addGestureRecognizer:tapGesture];
    self.navigationItem.titleView = topBkView;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y + _tableView.contentInset.top;
    if (offsetY < 0 && offsetY >= -150) {
        _topImageView.transform = CGAffineTransformMakeScale(1 + offsetY/(-300), 1 + offsetY/(-300));
        //        _topImageView.layer.anchorPoint = CGPointMake(0.5, offsetY/600. + 0.5);
        //        NSLog(@"%lf - %lf", offsetY, 1 + offsetY/(-300));
    }
    else if (offsetY >= 0 && offsetY <= 165) {
        _topImageView.transform = CGAffineTransformMakeScale(1 - offsetY/300, 1 - offsetY/300);
        //        _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5 + offsetY/600.);
    }
    else if (offsetY > 165) {
        _topImageView.transform = CGAffineTransformMakeScale(0.45, 0.45);
        //        _topImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    }
    else if (offsetY < -150) {
        _topImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        //        _topImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    
    CGRect frame = _topImageView.frame;
    frame.origin.y = 5;
    _topImageView.frame = frame;
    
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = [self randomColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIColor *)randomColor {
    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);
    return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:0.8];
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
