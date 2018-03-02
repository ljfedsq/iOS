//
//  MainChooseButtonView.h
//  EnvisionMobile1.1
//
//  Created by zhangyongbing on 15-4-27.
//  Copyright (c) 2015年 zhangyongbing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    largerView = 0,
    AverageView,
    middleView,
    smallView,
    secondView,
    drawerView
}ChooseViewType;

typedef enum
{
    tagWindFramMonitor = 0,
    tagOptimizationAnalysis,
    tagWorkFlow,
    tagPersonnelDynamic,
    tagComparsite,
    tagStockSupmarket,
    tagMaintance,
    tagGroup,
    tagFeecback,
    tagTurbineList,
    tagMore,
    tagDailyReport,
    tagWorkSearch,
    tagFleetView
}chooseViewTag;

@protocol MainChooseButtonViewDelegate <NSObject>

-(void)onChooseButtonPressed:(chooseViewTag)tag;

@end

@interface MainChooseButtonView : UIView
@property (nonatomic,weak) IBOutlet   id<MainChooseButtonViewDelegate> mdelegate;
@property (nonatomic) chooseViewTag         mtag;

- (void)setTitle:(NSString *)title AndIcon:(UIImage *)imageIcon WithType:(ChooseViewType)viewtype;
- (void)setViewLock:(BOOL)islock;
- (void)setViewTag:(chooseViewTag)atag;

@end
