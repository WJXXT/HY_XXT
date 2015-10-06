//
//  HYTabBar.m
//  HY_XXT
//
//  Created by XXT on 15/10/6.
//  Copyright (c) 2015年 XXT. All rights reserved.
//
#define kButtonWidht 100
#define kButtonHeight 44
#import "HYTabBar.h"
#import "HYTabBarButton.h"
@interface HYTabBar ()
/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;
@end
@implementation HYTabBar

- (void)addButton {
    // Do any additional setup after loading the view.
    self.backgroundColor =[UIColor whiteColor];
//    self.tabBarView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
    HYTabBarButton *findButton =[[HYTabBarButton alloc] initWithcreateImageNormal:@"icon_menu_home" ImageSelect:@"icon_menu_homeon" name:@"发现" index:0];
    [findButton addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:findButton];
    findButton.selected =YES;
    self.selectedBtn=findButton;

    HYTabBarButton *buyButton =[[HYTabBarButton alloc] initWithcreateImageNormal:@"icon_menu_film" ImageSelect:@"icon_menu_filmon" name:@"购票" index:1];
    [self addSubview:buyButton];
    [buyButton addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
    HYTabBarButton *activityButton =[[HYTabBarButton alloc] initWithcreateImageNormal:@"icon_menu_activity" ImageSelect:@"icon_menu_activityon" name:@"活动" index:2];
    [self addSubview:activityButton];
    [activityButton addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
    HYTabBarButton *movieButton =[[HYTabBarButton alloc] initWithcreateImageNormal:@"icon_movieline_off" ImageSelect:@"icon_movieline_on" name:@"电影圈" index:3];
    [self addSubview:movieButton];
    [movieButton addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
    
    HYTabBarButton *whiteButton =[[HYTabBarButton alloc] initWithcreateImageNormal:@" " ImageSelect:@" " name:@"" index:4];
    [self addSubview:whiteButton];
    UIButton *userButton =[UIButton buttonWithType:UIButtonTypeCustom];
    userButton.tag =106;
    userButton.frame =CGRectMake(325, 0, 50, 44);
    [userButton setImage:[UIImage imageNamed:@"icon_menu_user"] forState:UIControlStateNormal];
    [userButton setImage:[UIImage imageNamed:@"icon_menu_useron"] forState:UIControlStateSelected];
    [self addSubview:userButton];
    [userButton addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//
//    NSInteger count = self.subviews.count;
//    for (int i = 0; i < count; i++) {
//        //取得按钮
//        UIButton *btn = self.subviews[i];
//        
//        if (i== 0) {
//            btn.frame =CGRectMake(kButtonWidht/2*i, 0, kButtonWidht, kButtonHeight);
//        }else{
//            self.frame =CGRectMake(kButtonWidht/2*i+50, 0, kButtonWidht, kButtonHeight);
//        }
//    }
//}

-(void)btAction:(UIButton *)button{
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    self.selectedBtn =button;
    //2.再将当前按钮设置为选中
    button.selected = YES;
    //3.最后把当前按钮赋值为之前选中的按钮

    NSInteger tag =button.tag;
    
    if (tag ==106) {
        tag--;
        [UIView animateWithDuration:0.3 animations:^{
            [self viewWithTag:tag].frame =CGRectMake(200, 0, 100, 44);
        }];
        while (tag>102) {
            tag--;
            [UIView animateWithDuration:0.3 animations:^{
                [self viewWithTag:tag].frame =CGRectMake((tag -101)*50, 0, 100, 44) ;
            }];
        }
    }
    else if ([self viewWithTag:tag].frame.origin.x !=(tag -101)*50) {
        [UIView animateWithDuration:0.3 animations:^{
            [self viewWithTag:tag].frame =CGRectMake((tag -101)*50, 0, 100, 44) ;
        }];
        while (tag>102) {
            tag--;
            [UIView animateWithDuration:0.3 animations:^{
                [self viewWithTag:tag].frame =CGRectMake((tag -101)*50, 0, 100, 44) ;
            }];
        }
    }else{
        while (tag<105) {
            tag++;
            [UIView animateWithDuration:0.3 animations:^{
                [self viewWithTag:tag].frame =CGRectMake((tag -100)*50, 0, 100, 44) ;
            }];
        }
        if (tag == 105) {
            [UIView animateWithDuration:0.3 animations:^{
                [self viewWithTag:tag].frame =CGRectMake((tag -100)*50, 0, 50, 44) ;
            }];
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }
}


@end
