//
//  taskListModal.m
//  ToDoList
//
//  Created by MinBaby on 2018/1/25.
//  Copyright © 2018年 MinBaby. All rights reserved.
//

#import "taskListModal.h"

@implementation taskListModal
- (instancetype)init{
    self = [super init];
    if (self) {
        self.taskId = @"001";
        self.taskStr = @"第一个数据";
    }
    return self;
}

//-(void)addTask:(NSString * )item{
//    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:self.myTaskList];
//    [mutableArr addObject:item];
//    self.myTaskList = mutableArr;
//}
//
//-(void)removeTask:(NSString *)itemId{
//    
//}

@end
