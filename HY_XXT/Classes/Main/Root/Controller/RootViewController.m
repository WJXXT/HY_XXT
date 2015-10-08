//
//  RootViewController.m
//  HY_XXT
//
//  Created by XXT on 15/10/6.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "RootViewController.h"
#import "FinderController.h"
#import "ActivityController.h"
#import "MoviesViewController.h"
#import "CalenderController.h"
#import "HYTabBarButton.h"
#import "HYTabBar.h"
#import "AFNReuest.h"

@interface RootViewController ()<HYTabBarDelegate>
@property (nonatomic,strong)FinderController *finder;
@property (nonatomic,strong)MoviesViewController *movie;
@property (nonatomic,strong)ActivityController *activity;
@property (nonatomic,strong)CalenderController *calender;
@end

@implementation RootViewController
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [child removeFromSuperview];
        }
    }
}

//- (void)viewWillAppear:(BOOL)animated

//{
//
//    // 删除系统自动生成的UITabBarButton
//    
//    for (UIView *child in self.tabBar.subviews) {
//        
//        if ([child isKindOfClass:[UIControl class]]) {
//            
//            [child removeFromSuperview];
//            
//        }
//        
//    }
//    
//    [super viewWillAppear:animated];
//

//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
    HYTabBar *myView = [[HYTabBar alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
    myView.delegate = self; //设置代理
    myView.frame = rect;
    
    [self.tabBar addSubview:myView];
    [myView addButton];
    
    _finder =[[FinderController alloc]init];
    [self addChildViewController:_finder];
    
    
    _movie =[[MoviesViewController alloc]init];
    UINavigationController *moviena =[[UINavigationController alloc]initWithRootViewController:_movie];

    [self addChildViewController:moviena];
    
    _activity =[[ActivityController alloc]init];
    [self addChildViewController:_activity];

    _calender =[[CalenderController alloc]init];
    [self addChildViewController:_calender];
    

}



- (void)tabBar:(HYTabBar *)tabBar selectedFrom:(NSInteger)fromTag to:(NSInteger)toTag {

    self.selectedIndex = toTag-101;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
