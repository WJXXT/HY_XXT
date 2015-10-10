//
//  HeaderButton.m
//  HY_XXT
//
//  Created by XXT on 15/10/10.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "HeaderButton.h"

@implementation HeaderButton

-(void)layoutButtonIndex:(NSInteger)index{
    self.backgroundColor =[UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc]init];
    UILabel *bigLab =[[UILabel alloc]init];
    bigLab.font =[UIFont fontWithName:@"Helvetica-Bold" size:13];
    bigLab.frame =CGRectMake(5, 10, 100, 15);
    UILabel *smallLab =[[UILabel alloc]init];
    smallLab.font =[UIFont fontWithName:@"Helvetica" size:8];
    smallLab.frame =CGRectMake(5, 25, 100, 10);
    if (index ==1) {
        bigLab.text =@"每日红包";
        smallLab.text = @"手机领取专享";
        imgView.frame =CGRectMake(10, 35, self.frame.size.width-30, self.frame.size.height-60);
        imgView.image =[UIImage imageNamed:@"activity_redpack"];
    }
    if (index ==2) {
        bigLab.text =@"明星见面会";
        smallLab.text = @"映前映后见面会";
        imgView.frame =CGRectMake(100+10, 0, self.frame.size.width-100-20, self.frame.size.height);
        imgView.image =[UIImage imageNamed:@"activity_jmh"];
       
    }
    if (index ==3) {
        bigLab.center =CGPointMake(self.bounds.size.width/2, self.bounds.size.height -15);
        bigLab.text =@"抢票";
        bigLab.textAlignment =1;
        smallLab.center =CGPointMake(self.bounds.size.width/2, self.bounds.size.height -5);
        smallLab.text = @"低价想不到";
        smallLab.textAlignment =1;
        imgView.frame =CGRectMake(15, 5, self.frame.size.width-30, self.frame.size.height-40);
        imgView.image =[UIImage imageNamed:@"activity_qp"];

    }
    if (index ==4) {
        bigLab.center =CGPointMake(self.bounds.size.width/2, self.bounds.size.height -15);
        bigLab.text =@"用户反馈";
        bigLab.textAlignment =1;
        smallLab.center =CGPointMake(self.bounds.size.width/2, self.bounds.size.height -5);
        smallLab.text = @"世界应你而精彩";
        smallLab.textAlignment =1;
        imgView.frame =CGRectMake(15, 5, self.frame.size.width-30, self.frame.size.height-40);
        imgView.image =[UIImage imageNamed:@"activity_feedback"];

    }
    [self addSubview:bigLab];
    [self addSubview:smallLab];
    [self addSubview:imgView];
}

@end
