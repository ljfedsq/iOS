//
//  NSData+Base64.h
//  Learning iOS
//
//  Created by MinBaby on 2018/2/12.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)

+ (NSData *)base64DataFromString:(NSString *)string;

@end
