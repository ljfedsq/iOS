//
//  MainChooseButtonView.m
//  EnvisionMobile1.1
//
//  Created by zhangyongbing on 15-4-27.
//  Copyright (c) 2015年 zhangyongbing. All rights reserved.
//

#import "MainChooseButtonView.h"

@interface MainChooseButtonView ()
@property (nonatomic, strong) UIImageView   *imgBg;
@property (nonatomic, strong) UIImageView   *imgIcon;
@property (nonatomic, strong) UIImageView   *imgLock;
@property (nonatomic, strong) UILabel       *labTitle;
@property (nonatomic, strong) UIButton      *buttonMain;

@end

@implementation MainChooseButtonView

- (id)init
{
    self = [super init];
    if (self) {
        [self initSelfView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initSelfView];
}

- (void)initSelfView
{
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.layer.cornerRadius = 1;
    self.layer.masksToBounds = YES;
    //    self.alpha = 0.8;
    
    self.imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.imgBg setBackgroundColor:[UIColor whiteColor]];
    [self.imgBg setAlpha:0.2];
    self.imgBg.layer.cornerRadius = 3;
    self.imgBg.layer.masksToBounds = YES;
    [self addSubview:self.imgBg];
    
    self.imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.imgIcon setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.imgIcon];
    
    self.imgLock = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.imgLock setBackgroundColor:[UIColor clearColor]];
    [self.imgLock setImage:[UIImage imageNamed:@"ic_lock.png"]];
    [self addSubview:self.imgLock];
    [self.imgLock setHidden:YES];
    
    self.labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.labTitle setBackgroundColor:[UIColor clearColor]];
    [self.labTitle setTextColor:[UIColor whiteColor]];
    [self.labTitle setTextAlignment:NSTextAlignmentCenter];
    [self.labTitle setFont:[UIFont systemFontOfSize:16.0]];
    [self.labTitle setNumberOfLines:0];
    self.labTitle.adjustsFontSizeToFitWidth = YES;
//    self.labTitle.minimumFontSize = 8.0;
    self.labTitle.minimumScaleFactor = 0.5;
    [self addSubview:self.labTitle];
    
    self.buttonMain = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.buttonMain setBackgroundColor:[UIColor clearColor]];
    [self.buttonMain addTarget:self action:@selector(onButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.buttonMain];
}

- (void)onButtonPressed
{
    if (self.mdelegate && [self.mdelegate respondsToSelector:@selector(onChooseButtonPressed:)]) {
        [self.mdelegate onChooseButtonPressed:self.mtag];
    }
}

- (void)setTitle:(NSString *)title AndIcon:(UIImage *)imageIcon WithType:(ChooseViewType)viewtype
{
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfheigh = self.frame.size.height;
    
    [self.imgBg setBackgroundColor:[UIColor whiteColor]];
    [self.imgBg setAlpha:0.2];
    [self.imgBg setFrame:CGRectMake(0, 0, selfWidth, selfheigh)];
    [self.buttonMain setFrame:CGRectMake(0, 0, selfWidth, selfheigh)];
    
    [self.labTitle setTextAlignment:NSTextAlignmentCenter];
    [self.labTitle setFont:[UIFont systemFontOfSize:16.0]];
    CGFloat labPointY = selfheigh - 30;//标签靠下。高度20.
    if (viewtype == largerView) {
        [self.labTitle setFrame:CGRectMake(0, labPointY, selfWidth, 20)];
        //
        CGFloat imgIconWidth = selfWidth * 0.55;
        CGFloat imgIconPointX = (selfWidth - imgIconWidth)/2;
        CGFloat imgIconPointY = (selfheigh - 30 - imgIconWidth)/2;
        [self.imgIcon setFrame:CGRectMake(imgIconPointX, imgIconPointY, imgIconWidth, imgIconWidth)];
        
        [self.imgLock setFrame:CGRectMake(selfWidth - 25, 25, 15, 15)];
    }
    else if (viewtype == middleView)
    {
        [self.labTitle setFrame:CGRectMake(0, labPointY, selfWidth, 20)];
        //
        CGFloat imgIconWidth = selfWidth * 0.35;
        CGFloat imgIconPointX = (selfWidth - imgIconWidth)/2;
        CGFloat imgIconPointY = (selfheigh - 30 - imgIconWidth)/2;
        [self.imgIcon setFrame:CGRectMake(imgIconPointX, imgIconPointY, imgIconWidth, imgIconWidth)];
        
        [self.imgLock setFrame:CGRectMake(selfWidth - 25, 25, 15, 15)];
    }
    else if (viewtype == smallView)
    {
        //更多等小的view布局
        CGFloat imgIconigh = selfheigh * 0.32;
        
        CGSize titleSize = [title boundingRectWithSize:CGSizeMake(selfWidth-imgIconigh-10, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil].size;
        
        CGFloat imgIconPointX = (selfWidth - imgIconigh - titleSize.width - 10)/2;
        CGFloat imgIconPointY = (selfheigh-imgIconigh)/2;
        [self.imgIcon setFrame:CGRectMake(imgIconPointX, imgIconPointY, imgIconigh, imgIconigh)];
        
        [self.labTitle setFrame:CGRectMake(imgIconPointX + imgIconigh +10, imgIconPointY, titleSize.width, imgIconigh)];
        
        [self.imgLock setFrame:CGRectMake(selfWidth - 20, 15, 15, 15)];
    }
    else if (viewtype == secondView)
    {
        labPointY = selfheigh - 30;
        [self.labTitle setFont:[UIFont systemFontOfSize:12.0]];
        [self.labTitle setFrame:CGRectMake(0, labPointY, selfWidth, 30)];
        //
        CGFloat imgIconWidth = selfWidth * 0.35;
        CGFloat imgIconPointX = (selfWidth - imgIconWidth)/2;
        CGFloat imgIconPointY = (selfheigh - 30 - imgIconWidth)/2;
        [self.imgIcon setFrame:CGRectMake(imgIconPointX, imgIconPointY, imgIconWidth, imgIconWidth)];
        
        [self.imgLock setFrame:CGRectMake(selfWidth - 15, 12, 10, 10)];
    }
    else if (viewtype == drawerView)
    {
        [self.imgBg setBackgroundColor:[UIColor blackColor]];
        [self.imgBg setAlpha:0.35];
        [self.labTitle setTextAlignment:NSTextAlignmentLeft];
        [self.imgIcon setFrame:CGRectMake(10, 5, 30, 30)];
        [self.labTitle setFrame:CGRectMake(80, 10, 200, 20)];
        [self.imgLock setFrame:CGRectMake(220, 15, 10, 10)];
    }
    else if (viewtype == AverageView)
    {
        [self.labTitle setFrame:CGRectMake(0, labPointY, selfWidth, 20)];
        //
        CGFloat imgIconWidth = selfWidth * 0.55;
        CGFloat imgIconPointX = (selfWidth - imgIconWidth)/2;
        CGFloat imgIconPointY = (selfheigh - 30 - imgIconWidth)/2;
        [self.imgIcon setFrame:CGRectMake(imgIconPointX, imgIconPointY, imgIconWidth, imgIconWidth)];
        
        [self.imgLock setFrame:CGRectMake(selfWidth - 25, 25, 15, 15)];
    }
    
    [self.imgIcon setImage:imageIcon];
    [self.labTitle setText:title];
}

- (void)setViewLock:(BOOL)islock
{
    if (islock) {
        [self.imgLock setHidden:NO];
    }
    else
    {
        [self.imgLock setHidden:YES];
    }
}

- (void)setViewTag:(chooseViewTag)atag
{
    self.mtag = atag;
}

@end
