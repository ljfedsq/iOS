//
//  WindAppServices.h
//  Learning iOS
//
//  Created by MinBaby on 2018/2/11.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceBase.h"

@interface WindAppServices : NSObject

-(void)onLoginServicesWithUser:(NSString *)strusername
                        AndPsd:(NSString *)password
                 AndDomainCode:(NSString *)domainCode
               blockWithSucces:(void (^)(NSArray *dataArray))success
                       failure:(void (^)(NSString *error))failure;

@end
