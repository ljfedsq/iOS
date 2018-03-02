//
//  HomePageViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/13.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "HomePageViewController.h"
#import "Masonry.h"
#import "MainChooseButtonView.h"

@interface HomePageViewController ()<MainChooseButtonViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *homeScroll;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFrame];
}

-(void)initFrame{
    self.title = @"首页";
    //self.homeScroll.backgroundColor = [UIColor grayColor];
    [self.homeScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    NSArray *array = @[];
    if([self.numberOfPanel isEqualToString:@"4"]){
        array = [NSArray arrayWithObjects:@"one",@"two",@"three",@"four", nil];
    }else if([self.numberOfPanel isEqualToString:@"5"]){
       array = [NSArray arrayWithObjects:@"one",@"two",@"three",@"four",@"five", nil];
    }else {
        array = [NSArray arrayWithObjects:@"one",@"two",@"three",@"four",@"five",@"more", nil];
    }
     [self setChooseBtnViewControlWithArr:array];
}

-(void) setChooseBtnViewControlWithArr:(NSArray *)array {
    if([array count] == 4){
        CGRect rect;
        for(NSInteger i=0;i<4;i++){
            NSInteger line = i/2;
            NSInteger row = i%2;
            CGFloat PointX = 10 + 153 * row;
            CGFloat PointY = 73 + 217 * line;
            rect = CGRectMake(PointX, PointY, 147, 212);
            [self setChooseBtnViewWithCGRect:rect ChooseViewType:AverageView content:array[i]];
        }
    }else if([array count] == 5){
        CGRect rect = CGRectMake(0, 0, 0, 0);
        ChooseViewType choosetype = middleView;
        for(NSInteger i=0;i<5;i++){
            if(i == 0){
                rect = CGRectMake(10, 80, 147, 285);
                choosetype = largerView;
            }else if(i == 1){
                rect = CGRectMake(163, 80, 147, 140);
            }else if(i == 2){
                rect = CGRectMake(163, 225, 147, 140);
            }else if(i == 3){
                rect = CGRectMake(10, 370, 147, 140);
            }else if(i == 4){
                rect = CGRectMake(163, 370, 147, 140);
            }
            [self setChooseBtnViewWithCGRect:rect ChooseViewType:choosetype content:array[i]];
        }
    }else if([array count] >= 6){
        CGRect rect = CGRectMake(0, 0, 0, 0);
        ChooseViewType choosetype = middleView;
        for(NSInteger i=0;i<6;i++){
            if(i == 0){
                rect = CGRectMake(10, 80, 147, 285);
                choosetype = largerView;
            }else if(i == 1){
                rect = CGRectMake(163, 80, 147, 140);
            }else if(i == 2){
                rect = CGRectMake(163, 225, 147, 140);
            }else if(i == 3){
                rect = CGRectMake(10, 370, 147, 140);
            }else if(i == 4){
                rect = CGRectMake(163, 370, 147, 67);
                choosetype = smallView;
            }else if(i == 5){
                rect = CGRectMake(163, 443, 147, 67);
                choosetype = smallView;
            }
            [self setChooseBtnViewWithCGRect:rect ChooseViewType:choosetype content:array[i]];
        }
    }
}

-(void)setChooseBtnViewWithCGRect:(CGRect)rect ChooseViewType:(ChooseViewType)chooseType content:(NSString *)title {
    MainChooseButtonView * chooseView = [[MainChooseButtonView alloc]init];
    [chooseView setFrame:rect];
    [chooseView setTitle:NSLocalizedString(title, nil) AndIcon:[UIImage imageNamed:@"ic_monitor.png"] WithType:chooseType];
    chooseView.mdelegate = self;
    [self.homeScroll addSubview:chooseView];
}


#pragma mark ChooseButton
-(void)onChooseButtonPressed:(chooseViewTag)tag
{
    
}



@end
