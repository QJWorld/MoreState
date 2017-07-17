//
//  ViewController.m
//  MoreState(多态使用)
//
//  Created by QIUJUN on 2017/7/17.
//  Copyright © 2017年 QIUJUN. All rights reserved.
//

#import "ViewController.h"
#import "Animal.h"
#import "Cat.h"
#import "Dog.h"
#import "Cow.h"
#import "Pig.h"

@interface ViewController ()

@end
/*  编译时:  父类的指针指向 子类初始化好的对象;(多态特性,临时类型),编译后,运行时会根据 子类的类型动态绑定好 子类的具体类型, 父类 统一定义好 接口方法 给外界统一调用,子类负责 实现好对应的接口.
   当 父类指向的 子类对象 去调用 统一接口时,系统根据子类对象的具体类型,去调用 具体对象 内部重写好的实现方法.(实现了调用同样的接口,指向不一样的行为)
 
 编译后,运行时:
 
 
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   Animal *dog = [[Dog alloc] init]; // 父类的指针指向 子类初始化好的对象
   Animal *cat = [[Cat alloc] init];
   Animal *cow = [[Cow alloc] init];
    
    // 根据子类的具体类型,调用具体实现方法
    [dog eat];  // 调用狗 的吃
    [cat eat];   // 调用猫 的吃
    [cow eat];    // 调用牛 的吃
    
    [dog laugh];  // 调用狗 的笑
    [cat laugh];  // 调用猫 的笑
    [cow laugh];  // 调用牛 的笑
    
    // 猪 (子类没有实现父类的接口时,就默认去调用父类的接口实现,如果父类也没用实现,就会报错,方法找不到错误)
   Animal *pig = [[Pig alloc] init];
    [pig eat];   // 调用类 父类annimal 的吃 方法
    [pig laugh];  //  调用类 父类annimal 的笑 方法
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
