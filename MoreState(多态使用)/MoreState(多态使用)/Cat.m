//
//  Cat.m
//  MoreState(多态使用)
//
//  Created by QIUJUN on 2017/7/17.
//  Copyright © 2017年 QIUJUN. All rights reserved.
//

#import "Cat.h"

@implementation Cat
-(void)eat {
//    [super eat]; 初始化调用 一下 父类的方法
    NSLog(@"猫吃鱼");
}

-(void)laugh {
    NSLog(@"猫=========喵喵叫");
    NSLog(@"猫=========喵喵叫");
}

-(void)jump {
    NSLog(@"狗急跳墙========");
}

@end
