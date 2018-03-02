//
//  NSLayoutConstraint+IBDesignable.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/6.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "NSLayoutConstraint+IBDesignable.h"

@implementation NSLayoutConstraint (IBDesignable)
-(void) setAdapterScreen:(BOOL)adapterScreen{
    if(adapterScreen) {
        self.constant = self.constant * KsuitParam;
    }
}
-(BOOL)adapterScreen{
    return YES;
}
@end
