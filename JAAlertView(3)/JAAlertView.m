//
//  JAAlertView.m
//  JAAlertViewDemo
//
//  Created by QIUJUN on 2017/7/12.
//  Copyright © 2017年 QIUJUN. All rights reserved.
//

#import "JAAlertView.h"
#import "Masonry.h"


@interface JAAlertView ()
@property(nonatomic,strong) UIButton *containView ;
@property(nonatomic,assign) CGFloat jaAlertW ;
@property(nonatomic,assign) CGFloat jaAlertH ;
@end

@implementation JAAlertView

-(JAAlertView *) jaAlertViewTitle:(NSString *)title Message:(NSString *)message ButtonsTitle:(NSArray<NSString *> *)buttonstitle {
    
    _jaAlertW = 260 ;
    _jaAlertH = 300 ;
    if (buttonstitle.count <= 2) {
        _jaAlertH = 100 + 47 ;  // 100 是标题 和message 还有间隙的总高度 , 47是一个按钮高度
    } else { // 大于 2个按钮
        _jaAlertH =  100 + buttonstitle.count*47 ;
    }
    
    CGFloat jaAlertX = [UIScreen mainScreen].bounds.size.width* 0.5 - _jaAlertW * 0.5 ;
    CGFloat jaAlertY = [UIScreen mainScreen].bounds.size.height* 0.5 - _jaAlertH * 0.5 ;
    // 动态计算 frame
    CGRect frame = CGRectMake(jaAlertX, jaAlertY, _jaAlertW, _jaAlertH);
    
    JAAlertView *jaAlertView = [super initWithFrame:frame] ;
    jaAlertView.backgroundColor = [UIColor whiteColor];
    jaAlertView.layer.cornerRadius = 10.0 ;
    jaAlertView.layer.masksToBounds = YES;
    [jaAlertView initJaAlertViewWithButtonsTitle:buttonstitle];
    // 设定 标题, message , buttontitle
    self.titleLabel.text = title;
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.messageLabel.text = message ;
    self.messageLabel.font = [UIFont systemFontOfSize:16.0];
    jaAlertView.userInteractionEnabled = YES ;
    return jaAlertView ;
}


// 展示
-(void)show {
    // 蒙板 是个按钮
    _containView = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _containView.backgroundColor = [UIColor colorWithRed:142.0/255 green:142.0/255 blue:142.0/255 alpha:0.8];
    _containView.userInteractionEnabled = YES ;
    [_containView addTarget:self action:@selector(removeAlert) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:_containView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
   __weak typeof(UIWindow *) weakWindow = [UIApplication sharedApplication].keyWindow ;
    
    [_containView  mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakWindow);
        make.size.equalTo(weakWindow);
    }];
    
    [self  mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakWindow);
        make.size.mas_equalTo(CGSizeMake(_jaAlertW, _jaAlertH));
    }];
}

-(void)removeAlert{
    [_containView removeFromSuperview];
    [self removeFromSuperview];
    
}

-(void) initJaAlertViewWithButtonsTitle:(NSArray<NSString *> *)buttonstitle {
    
    _titleLabel = [[UILabel alloc] init ];
    _titleLabel.textAlignment = NSTextAlignmentCenter ;
    _messageLabel = [[UILabel alloc] init ];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    
    // 根据传进来的 buttons 名字的个数,动态遍历 Button 按钮个数 .
    _btnsArray = [NSMutableArray array];
    for (int i = 0 ; i < buttonstitle.count ; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.layer.borderColor = [UIColor colorWithRed:207.0/255 green:207.0/255 blue:207.0/255 alpha:1.0].CGColor ;
        button.layer.borderWidth = 0.5 ;
        
        [button setTitle:buttonstitle[i] forState:UIControlStateNormal];
        button.tag = i ;
        // 为buton 添加 各种回调操作
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 默认 浅蓝色
        [button setTitleColor:[UIColor colorWithRed:0.0 green:137.0/255 blue:251.0/255 alpha:1.0] forState:UIControlStateNormal];
        
        [_btnsArray addObject:button];
    }
    
    [self addSubview:_titleLabel];
    [self addSubview:_messageLabel];
    __weak typeof (self) weakView = self;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakView).with.offset(15);
        make.left.equalTo(weakView);
        make.size.mas_equalTo(CGSizeMake(weakView.bounds.size.width, 44));
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel).with.offset(15);
        make.left.equalTo(weakView);
        // 此处 高度根据 字体内容进行动态计算
        make.size.mas_equalTo(CGSizeMake(weakView.bounds.size.width, 70));
    }];
    
    // 根据 buttons 的个数,进行分情况布局
    
    if (_btnsArray.count == 1) {
        [self addSubview: _btnsArray[0]];
        [_btnsArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_messageLabel.mas_bottom);
            make.left.equalTo(weakView);
            make.size.mas_equalTo(CGSizeMake(weakView.bounds.size.width, 47));
        }];
    }
    
    if (_btnsArray.count == 2) {
        [self addSubview: _btnsArray[0]];
        [self addSubview: _btnsArray[1]];
        
        [_btnsArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_messageLabel.mas_bottom);
            make.right.equalTo(weakView);
            make.size.mas_equalTo(CGSizeMake(weakView.bounds.size.width*0.5, 47));
        }];
        
        [_btnsArray[1] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_messageLabel.mas_bottom);
            make.left.equalTo(weakView);
            make.size.mas_equalTo(CGSizeMake(weakView.bounds.size.width*0.5, 47));
        }];
        
    }
    
    if (_btnsArray.count > 2) {
        for (int i = 0; i < _btnsArray.count ;  i++) {
            [self addSubview: _btnsArray[i]];
            // 此处 对不同的button 进行 不同的位置布局(主要是button的Y坐标改变,其他都不变)
            if (i == 0) { // 第 0 个button 布局
                [_btnsArray[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_messageLabel.mas_bottom);
                    make.left.equalTo(weakView);
                    make.size.mas_equalTo(CGSizeMake(weakView.bounds.size.width, 47));
                }];
            }else {  // 第 0 个 button以后 布局
                UIButton *lastBtn = _btnsArray[i-1];
                [_btnsArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastBtn.mas_bottom);
                    make.left.equalTo(weakView);
                    make.size.mas_equalTo(CGSizeMake(weakView.bounds.size.width, 47));
                }];
            }
        }
    }
    
}

// 不同 的按钮 响应 不同的回调 处理
-(void) buttonClick:(UIButton *)button {
    // 移除 当前的弹框
    [self removeAlert];
    // 根据button 的标号,进行调用 回调函数
    NSInteger index = button.tag ;
    if (self.jaAction) {  // 判断 block 是否有实现
        self.jaAction(index) ;
    }
    
}

-(void)dealloc{
    self.jaAction = nil ;
    NSLog(@"============================");
}


@end
