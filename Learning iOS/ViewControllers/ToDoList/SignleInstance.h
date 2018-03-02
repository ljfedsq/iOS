//
//  SignleInstance.h
//  ToDoList
//
//  Created by MinBaby on 2018/1/26.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignleInstance : NSObject

+(instancetype)sharedInstance;

@property(nonatomic,strong) NSArray *taskArr;

@end
