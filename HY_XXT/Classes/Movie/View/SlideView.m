//
//  SlideView.m
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "SlideView.h"
#import "SlideButton.h"
#import "MoviesViewController.h"
@interface SlideView ()
@property (nonatomic,strong)UIView *orge;
@property (nonatomic, weak) SlideButton *selectedBtn;
@property (nonatomic,strong)NSMutableArray *arr;

@end

@implementation SlideView
-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        SlideButton *lab1 =[[SlideButton alloc]initWithCreatename:@"正在热映" index:0];
        [lab1 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lab1];
        self.selectedBtn =lab1;
        self.selectedBtn.selected =YES;
        SlideButton *lab2 =[[SlideButton alloc]initWithCreatename:@"即将上映" index:1];
        [lab2 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lab2];
        SlideButton *lab3 =[[SlideButton alloc]initWithCreatename:@"售票排行" index:2];
        [lab3 addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lab3];
        _orge =[[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height -5, kScreenWidth/3, 5)];
        _orge.backgroundColor =[UIColor orangeColor];
//        self.userInteractionEnabled =YES;
        self.arr =[NSMutableArray arrayWithObjects:lab1,lab2,lab3, nil];
        [self addSubview:_orge];
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
        [center addObserver:self selector:@selector(notice:) name:@"123" object:nil];
    }
    return self;
}

-(void)btAction:(SlideButton *)button{
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    self.selectedBtn =button;
    //2.再将当前按钮设置为选中
    self.selectedBtn.selected = YES;
    if ([self.delegate respondsToSelector:@selector(actionbtIndex:)]) {
        [self.delegate actionbtIndex:self.selectedBtn.index];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.orge.center =CGPointMake(button.center.x, self.orge.center.y);
    }];
    
}
-(void)notice:(id)sender{
    NSString *str =[[sender valueForKey:@"userInfo"]valueForKey:@"indexs"];
    NSInteger index =[str integerValue];
    for (SlideButton *button in self.arr) {
        if (button.index ==index) {
            self.selectedBtn.selected = NO;
            self.selectedBtn =button;
            self.selectedBtn.selected = YES;
            [UIView animateWithDuration:0.3 animations:^{
                self.orge.center =CGPointMake(button.center.x, self.orge.center.y);
            }];
        }
    }
}

@end
