//
//  ChooseProduceViewController.h
//  Learning iOS
//
//  Created by MinBaby on 2018/2/7.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+Wind.h"

typedef enum {
    ProductionCH = 0,
    ProductionEN,
    Custom
}ServiceType;
typedef enum {
    Default = 0,
    Rollout
}CustomerType;


@protocol ChooseProduceViewDelegate <NSObject>

-(void)valueChange;
-(void)settingViewShow;

@end

@interface ChooseProduceView : UIView
@property(nonatomic,weak) id<ChooseProduceViewDelegate> mdelegate;
@property ServiceType type_ServiceIP;
@property CustomerType type_Customer;
@property(nonatomic,strong)IBOutlet UIButton    *button_Sure;
@property(nonatomic,strong)IBOutlet UIButton    *button_Cancle;
@property(nonatomic,strong)IBOutlet UIButton    *button_Setting;
@property(nonatomic,strong)IBOutlet UIImageView *img_CH;
@property(nonatomic,strong)IBOutlet UIImageView *img_EN;
@property(nonatomic,strong)IBOutlet UIImageView *img_CU;
@property(nonatomic,strong)IBOutlet UILabel     *lab_SelectData;
@property(nonatomic,strong)IBOutlet UILabel     *lab_China;
@property(nonatomic,strong)IBOutlet UILabel     *lab_USA;
@property(nonatomic,strong)IBOutlet UILabel     *lab_Custom;
@property(nonatomic,strong) NSString *viewType;
@property (weak, nonatomic) IBOutlet UIView *lastLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lastImageView;

-(IBAction) suerChoose:(id)sender;
-(IBAction) cancelChoose:(id)sender;
-(IBAction) chooseIPPressed:(id)sender;
-(IBAction) settingButtonPre:(id)sender;
-(void) showSettingButton;
-(void) hiddenSettingButton;
-(void) initView;
-(void) setViewLanguage;

@end
