//
//  NavigationView.m
//  CarsInfo
//
//  Created by qianfeng000 on 15/9/18.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "NavigationView.h"

@interface NavigationView ()

{
    
    NSMutableArray * btnArray;
}

@end

@implementation NavigationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeView];
    }
    return self;
}
-(void)makeView{
    btnArray = [[NSMutableArray alloc] init];
    NSArray * arr = @[@"new",@"dg",@"pc"];
    CGFloat btnW = kScreenWidth / 3.0;
    CGFloat btnH = 44;

    for (int index = 0; index < 3; index++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(index * btnW + 15, 0, btnW, btnH);
        btn.tag = 1+index;
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%@.png",arr[index]]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%@_press.png",arr[index]]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnArray addObject:btn];
        [self addSubview:btn];
        if (btn.tag == 1) {
            btn.selected = YES;
        }
    }
}
-(void)buttonClick:(UIButton *)btn {
    for (UIButton * btn in btnArray) {
        btn.selected = NO;
    }
    btn.selected = YES;
    if (self.clickBlock) {
        self.clickBlock(btn.tag);
    }
}

@end
