//
//  NSString+Wind.m
//  Learning iOS
//
//  Created by MinBaby on 2018/2/7.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "NSString+Wind.h"

@implementation NSString (Wind)
-(BOOL)stringIsValid
{
    BOOL isVaild = false;
    if ([self isEqual:[NSNull null]]) {
        return false;
    }
    if (self != nil && ![self isEqualToString:@""] && ![self isEqualToString:@"(null)"]) {
        isVaild = YES;
    }
    
    return isVaild;
}

-(BOOL)isEqualZero
{
    if (![self stringIsValid] || [self isEqualToString:@"0"]) {
        return YES;
    }
    return NO;
}

- (NSString *)toFormatNumberString
{
    @try
    {
        BOOL isminzero = NO;
        NSString *numStr = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        float selffloat = [numStr floatValue];
        if (selffloat < 0) {//判断是否为负数，负数转为正数添加逗号，返回的时候再加上负号
            isminzero = YES;
            numStr = [numStr substringFromIndex:1];
        }
        
        if (numStr.length < 3)
        {
            if (isminzero) {
                return [NSString stringWithFormat:@"-%@",numStr];
            }
            else
            {
                return numStr;
            }
        }
        NSArray *array = [numStr componentsSeparatedByString:@"."];
        NSString *numInt = [array objectAtIndex:0];
        if (numInt.length <= 3)
        {
            if (isminzero) {
                return [NSString stringWithFormat:@"-%@",numStr];
            }
            else
            {
                return numStr;
            }
        }
        NSString *suffixStr = @"";
        if ([array count] > 1)
        {
            NSString *strSuff = [NSString stringWithFormat:@"0.%@",[array objectAtIndex:1]];
            float fSuff = [strSuff floatValue];
            strSuff = [NSString stringWithFormat:@"%0.1f",fSuff];
            NSArray *arraySuff = [strSuff componentsSeparatedByString:@"."];
            suffixStr = [NSString stringWithFormat:@".%@",[arraySuff objectAtIndex:1]];
        }
        
        NSMutableArray *numArr = [[NSMutableArray alloc] init];
        while (numInt.length > 3)
        {
            NSString *temp = [numInt substringFromIndex:numInt.length - 3];
            numInt = [numInt substringToIndex:numInt.length - 3];
            [numArr addObject:[NSString stringWithFormat:@",%@",temp]];//得到的倒序的数据
        }
        NSInteger count = [numArr count];
        for (int i = 0; i < count; i++)
        {
            numInt = [numInt stringByAppendingFormat:@"%@",[numArr objectAtIndex:(count -1 -i)]];
        }
        numStr = [NSString stringWithFormat:@"%@%@",numInt,suffixStr];
        if (isminzero) {
            return [NSString stringWithFormat:@"-%@",numStr];
        }
        else
        {
            return numStr;
        }
    }
    @catch (NSException *exception)
    {
        return self;
    }
    @finally
    {}
    
}

@end
