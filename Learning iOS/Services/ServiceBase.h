//
//  ServiceBase.h
//  Learning iOS
//
//  Created by MinBaby on 2018/2/12.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface ServiceBase : NSObject

-(AFHTTPSessionManager *)sharedManager;

@end
