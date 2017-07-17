//
//  Animal.m
//  MoreState(多态使用)
//
//  Created by QIUJUN on 2017/7/17.
//  Copyright © 2017年 QIUJUN. All rights reserved.
//

#import "Animal.h"

@implementation Animal
-(void)eat {
    NSLog(@"子类%@没有实现吃的方法",[self class]);
}

-(void)laugh {
    NSLog(@"子类%@没有实现笑的方法",self);
}

@end
