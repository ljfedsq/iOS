//
//  InsetLabel.h
//  Learning iOS
//
//  Created by MinBaby on 2018/2/8.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetLabel : UILabel
@property(nonatomic) UIEdgeInsets insets;
//初始化方法一
-(id)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets) insets;
//初始化方法二
-(id)initWithInsets:(UIEdgeInsets)insets;
@end
