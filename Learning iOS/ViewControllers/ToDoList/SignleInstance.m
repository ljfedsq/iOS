//
//  SignleInstance.m
//  ToDoList
//
//  Created by MinBaby on 2018/1/26.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "SignleInstance.h"

@implementation SignleInstance

// 通过类方法创建单例对象
+(instancetype)sharedInstance {
    static SignleInstance * sharedVC = nil;//静态变量一旦被赋值，下次将读取上一次的值
    if(sharedVC == nil){
        sharedVC = [[SignleInstance alloc]init];
    }
    return sharedVC;
}

@end
