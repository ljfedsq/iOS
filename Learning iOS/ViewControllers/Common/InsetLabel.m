//
//  InsetLabel.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/8.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "InsetLabel.h"

@implementation InsetLabel

-(id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets) insets{
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(id)initWithInsets:(UIEdgeInsets)insets{
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(void)drawTextInRect:(CGRect)rect{
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}

@end
