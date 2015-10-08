//
//  DropActionView.m
//  HY_XXT
//
//  Created by XXT on 15/10/8.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "DropActionView.h"
#import "DropActionButton.h"
#import "DropDownMenuView.h"
@interface DropActionView ()
@property (nonatomic,weak)DropActionButton *selectBt;
@property (nonatomic,strong)DropDownMenuView *dropMenu;
@property (nonatomic,strong)UIView *bakview;
@end

@implementation DropActionView

-(id)initWithFrame:(CGRect)frame NameArr:(NSArray *)nameArr FileDic:(NSDictionary *)fileDic{
    self =[super initWithFrame:frame];
    if (self) {
        NSInteger index =nameArr.count;
        for (int i = 0;  i < index; i++) {
            NSString *str =nameArr[i];
            DropActionButton *bt =[[DropActionButton alloc]initWithCreateImageNormal:@"common_icon_small_arrow" ImageSelect:@"common_icon_yellow_arrow" name:str Frame:CGRectMake(kScreenWidth/index*i, 0, kScreenWidth/index, 40)];
            bt.arr =[fileDic valueForKey:str];
            [bt addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:bt];
        }
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"Cinemanot" object:nil];
    }
    return self;
}

-(void)btAction:(DropActionButton *)bt{
    if (_selectBt == nil) {
        self.selectBt =bt;
        self.dropMenu =[[DropDownMenuView alloc]initWithHeight:44 AllFileKey:bt.arr];
        [self layoutMohu];
        [self addSubview:self.dropMenu];
        [self sendSubviewToBack:self.dropMenu];
        [UIView animateWithDuration:0.3 animations:^{
            self.frame =CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            self.bakview.alpha = 0.5;
            self.bakview.frame =CGRectMake(0, 44+self.dropMenu.frame.size.height, kScreenWidth, kScreenHeight);
            self.dropMenu.frame =CGRectMake(0, 44, kScreenWidth, self.dropMenu.frame.size.height);
        } ];

        self.selectBt.selected = YES;
    }else if (_selectBt ==bt){
        [UIView animateWithDuration:0.3 animations:^{
            self.dropMenu.alpha = 0;
            self.bakview.alpha = 0;
            self.frame =CGRectMake(0, 0, kScreenWidth, 44);
            self.dropMenu.frame =CGRectMake(0, 44-self.dropMenu.frame.size.height, kScreenWidth, self.dropMenu.frame.size.height);
             self.bakview.frame =CGRectMake(0, 44, kScreenWidth, kScreenHeight);
        } completion:^(BOOL finished) {
            [self.dropMenu removeFromSuperview];
            [self.bakview removeFromSuperview];
        }];
        self.selectBt.selected = NO;
        self.selectBt =nil;
    }else{
        self.selectBt.selected =NO;
        self.selectBt =bt;
        [UIView animateWithDuration:0.3 animations:^{
            self.bakview.frame =CGRectMake(0, 44, kScreenWidth, kScreenHeight);
            self.dropMenu.alpha = 0;
            self.dropMenu.frame =CGRectMake(0, 44-self.dropMenu.frame.size.height, kScreenWidth, self.dropMenu.frame.size.height);
        } completion:^(BOOL finished) {
            [self.dropMenu removeFromSuperview];
            self.dropMenu =[[DropDownMenuView alloc]initWithHeight:44 AllFileKey:bt.arr];
            self.dropMenu.alpha = 1;
            [self addSubview:self.dropMenu];
            [self sendSubviewToBack:self.dropMenu];
            [UIView animateWithDuration:0.3 animations:^{
                self.bakview.frame =CGRectMake(0, 44+self.dropMenu.frame.size.height, kScreenWidth, kScreenHeight);
                self.frame =CGRectMake(0, 0, kScreenWidth, self.dropMenu.frame.size.height+44);
                self.dropMenu.frame =CGRectMake(0, 44, kScreenWidth, self.dropMenu.frame.size.height);
            }];
        }];
        self.selectBt.selected =YES;
    }
}

-(void)layoutMohu{
    self.bakview =[[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight)];
    self.bakview.alpha =0.0;
    self.bakview.backgroundColor =[UIColor blackColor];
    [self addSubview:self.bakview];
    self.bakview.userInteractionEnabled =YES;
    
    //    轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //    配置属性
    //    轻拍次数
    tap.numberOfTapsRequired =1;
    //    轻拍 手指的个数
    tap.numberOfTouchesRequired =1;
    //    将手势 添加到指定视图上
    [self.bakview addGestureRecognizer:tap];
}
//接收通知
- (void)tongzhi:(NSNotification *)text{
    [UIView animateWithDuration:0.3 delay:0.2 options:0 animations:^{
        self.dropMenu.alpha = 0;
        self.bakview.alpha = 0;
        self.frame =CGRectMake(0, 0, kScreenWidth, 44);
        self.dropMenu.frame =CGRectMake(0, 44-self.dropMenu.frame.size.height, kScreenWidth, self.dropMenu.frame.size.height);
        self.bakview.frame =CGRectMake(0, 44, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        [self.dropMenu removeFromSuperview];
        [self.bakview removeFromSuperview];
    }];
    self.selectBt.selected = NO;
    self.selectBt =nil;
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Cinemanot" object:nil];
}

#pragma mark -手势触发事件
-(void)tapAction:(UITapGestureRecognizer *)tap{
    [UIView animateWithDuration:0.3 animations:^{
        self.dropMenu.alpha = 0;
        self.bakview.alpha = 0;
        self.frame =CGRectMake(0, 0, kScreenWidth, 44);
        self.dropMenu.frame =CGRectMake(0, 44-self.dropMenu.frame.size.height, kScreenWidth, self.dropMenu.frame.size.height);
        self.bakview.frame =CGRectMake(0, 44, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        [self.dropMenu removeFromSuperview];
        [self.bakview removeFromSuperview];
    }];
    self.selectBt.selected = NO;
    self.selectBt =nil;
    [self.bakview removeGestureRecognizer:tap];
}


@end
