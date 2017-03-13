//
//  pictureView.m
//  CarsInfo
//
//  Created by qianfeng on 15/9/24.
//  Copyright (c) 2015年 WenDeFeng. All rights reserved.
//

#import "pictureView.h"

@interface pictureView (){
    
    NSMutableArray *btnArray;
    
}

@end

@implementation pictureView

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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"cellbar.png"];
    [self addSubview:imageView];
    CGFloat btnW = kScreenWidth * 0.5;
    NSArray *arr = @[@"model",@"carpic"];
    for (int i = 0; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i* btnW + 15, 0, btnW, 44);
        btn.tag = i+1;
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%@.png",arr[i]]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tab_%@_press.png",arr[i]]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        [btnArray addObject:btn];
        if (btn.tag == 1) {
            btn.selected = YES;
        }
    }
}
-(void)buttonClick:(UIButton *)button{
    for (UIButton * button in btnArray) {
        button.selected = NO;
    }
    button.selected = YES;
    if (self.clickBlock) {
        self.clickBlock(button.tag);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
