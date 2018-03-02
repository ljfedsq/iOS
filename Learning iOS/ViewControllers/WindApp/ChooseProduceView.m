//
//  ChooseProduceViewController.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/7.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "ChooseProduceView.h"

@interface ChooseProduceView ()

@end

@implementation ChooseProduceView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    UIImage* image = [UIImage imageNamed:@"bg_white_rec.png"];
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 20, 20, 20);
    image = [image resizableImageWithCapInsets:insets];
    [self.button_Sure setBackgroundImage:image forState:UIControlStateNormal];
    [self.button_Cancle setBackgroundImage:image forState:UIControlStateNormal];
    [self.button_Setting setBackgroundImage:image forState:UIControlStateNormal];
    [self initView];
    [self setViewLanguage];
}

-(void) setViewLanguage
{
    [self.lab_SelectData setText:NSLocalizedString(@"Select Data", nil)];
    [self.button_Sure setTitle:NSLocalizedString(@"Sure", nil) forState:UIControlStateNormal];
    [self.button_Cancle setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [self.button_Setting setTitle:NSLocalizedString(@"Setting", nil) forState:UIControlStateNormal];
    if([self.viewType isEqualToString:@"ip"]){
        [self.lab_China setText:NSLocalizedString(@"China", nil)];
        [self.lab_USA setText:NSLocalizedString(@"International", nil)];
        [self.lab_Custom setText:NSLocalizedString(@"Custom Environment", nil)];
    }else{
        [self.lab_China setText:NSLocalizedString(@"Default", nil)];
        [self.lab_USA setText:NSLocalizedString(@"Envision Protal", nil)];
        [self.lastLabel setAlpha:0];
        [self.lastImageView setAlpha:0];
    }
}

-(void)initView
{
    self.viewType = [[NSUserDefaults standardUserDefaults] objectForKey:@"viewType"];
    if([self.viewType isEqualToString:@"ip"]){
        NSString *type = [[NSUserDefaults standardUserDefaults] valueForKey:IPTYPE];
        if (![type stringIsValid]) {
            type = ProductionCH;
        }
        ServiceType inttype = (ServiceType)[type integerValue];
        switch (inttype) {
            case ProductionCH:
            {
                [self.img_CH setImage:[UIImage imageNamed:@"ic_checked"]];
                self.type_ServiceIP = ProductionCH;
                break;
            }
            case ProductionEN:
            {
                [self.img_EN setImage:[UIImage imageNamed:@"ic_checked"]];
                self.type_ServiceIP = ProductionEN;
                break;
            }
            case Custom:
            {
                [self.img_CU setImage:[UIImage imageNamed:@"ic_checked"]];
                self.type_ServiceIP = Custom;
                [self showSettingButton];
                break;
            }
            default:
                break;
        }
        
    }else{
        NSString *type = [[NSUserDefaults standardUserDefaults] valueForKey: CUSTOMERTYPE];
        if (![type stringIsValid]) {
            type = Default;
        }
        CustomerType inttype = (CustomerType)[type integerValue];
        switch (inttype) {
            case Default:
            {
                [self.img_CH setImage:[UIImage imageNamed:@"ic_checked"]];
                self.type_Customer = Default;
                break;
            }
            case Rollout:
            {
                [self.img_EN setImage:[UIImage imageNamed:@"ic_checked"]];
                self.type_Customer = Rollout;
                break;
            }
            default:
                break;
        }
        
    }
    
}

-(IBAction) cancelChoose:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0];
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

-(IBAction) suerChoose:(id)sender
{
    if([self.viewType isEqualToString:@"ip"]){
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.type_ServiceIP] forKey:IPTYPE];
        if (self.mdelegate && [self.mdelegate respondsToSelector:@selector(valueChange)]) {
            [self.mdelegate valueChange];
        }
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.type_Customer] forKey:CUSTOMERTYPE];
        if (self.mdelegate && [self.mdelegate respondsToSelector:@selector(valueChange)]) {
            [self.mdelegate valueChange];
        }
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0];
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

-(IBAction) settingButtonPre:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.type_ServiceIP] forKey:IPTYPE];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.type_ServiceIP] forKey:CUSTOMERTYPE];
    if (self.mdelegate && [self.mdelegate respondsToSelector:@selector(valueChange)]) {
        [self.mdelegate valueChange];
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0];
    }completion:^(BOOL finished){
        if (self.mdelegate && [self.mdelegate respondsToSelector:@selector(settingViewShow)]) {
            [self.mdelegate settingViewShow];
        }
        [self removeFromSuperview];
    }];
}


-(IBAction) chooseIPPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self.img_CH setImage:[UIImage imageNamed:@"ic_unchecked"]];
    [self.img_EN setImage:[UIImage imageNamed:@"ic_unchecked"]];
    [self.img_CU setImage:[UIImage imageNamed:@"ic_unchecked"]];
    switch (btn.tag) {
        case 1001:
        {
            [self.img_CH setImage:[UIImage imageNamed:@"ic_checked"]];
            self.type_ServiceIP = ProductionCH;
            self.type_Customer = Default;
            [self hiddenSettingButton];
            break;
        }
        case 1002:
        {
            [self.img_EN setImage:[UIImage imageNamed:@"ic_checked"]];
            self.type_ServiceIP = ProductionEN;
            self.type_Customer = Rollout;
            [self hiddenSettingButton];
            break;
        }
        case 1003:
        {
            [self.img_CU setImage:[UIImage imageNamed:@"ic_checked"]];
            self.type_ServiceIP = Custom;
            [self showSettingButton];
            break;
        }
        default:
            break;
    }
}

-(void) showSettingButton
{
    [self.button_Setting setHidden:NO];
    [UIView animateWithDuration:0.5 animations:^
     {
         [self.button_Sure setFrame:CGRectMake(15, 270, 83, 40)];
         [self.button_Cancle setFrame:CGRectMake(108, 270, 83, 40)];
         [self.button_Setting setFrame:CGRectMake(201, 270, 83, 40)];
     }completion:nil];
}

-(void) hiddenSettingButton
{
    [UIView animateWithDuration:0.5 animations:^
     {
         [self.button_Sure setFrame:CGRectMake(15, 270, 130, 40)];
         [self.button_Cancle setFrame:CGRectMake(155, 270, 130, 40)];
         [self.button_Setting setFrame:CGRectMake(320, 270, 130, 40)];
     }completion:^(BOOL finished){
         [self.button_Setting setHidden:YES];
     }];
    
}

@end
