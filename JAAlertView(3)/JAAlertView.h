//
//  JAAlertView.h
//  JAAlertViewDemo
//
//  Created by QIUJUN on 2017/7/12.
//  Copyright © 2017年 QIUJUN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (__strong ^Action) (NSInteger);

@interface JAAlertView : UIView
// 可以拿到 titlelabel ,messageLabel , buttonArray ,进而 设定 字体大小,字体颜色,
@property(nonatomic,strong) UILabel *titleLabel ;

@property(nonatomic,strong) UILabel *messageLabel ;
// 可以拿到任意的 按钮进行 颜色字体大小设置
@property(nonatomic,strong) NSMutableArray<UIButton *> *btnsArray;

// 按钮的 回调操作
@property(nonatomic,strong) Action jaAction ;

-(JAAlertView *) jaAlertViewTitle:(NSString *)title Message:(NSString *)message ButtonsTitle:(NSArray<NSString *> *)buttonstitle ;
// 展示弹框
-(void)show;


@end
