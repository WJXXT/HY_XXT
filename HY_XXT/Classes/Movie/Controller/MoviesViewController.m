//
//  MoviesViewController.m
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "MoviesViewController.h"
#import "ShowmoiveTableViewController.h"
#import "WillMovieViewController.h"
#import "TopMovieViewController.h"
#import "CinemaController.h"
#import "SlideView.h"

@interface MoviesViewController ()<UIScrollViewDelegate,SlideViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)SlideView *slideview;
@property (nonatomic,strong)ShowmoiveTableViewController *showmoiveController;
@property (nonatomic,strong)WillMovieViewController *willmoiveController;
@property (nonatomic,strong)TopMovieViewController *topmoiveController;
@property (nonatomic,strong)CinemaController *cinemaController;
@end

@implementation MoviesViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.view.alpha =0;
    self.navigationController.navigationBar.translucent = NO;
    [self.view.layer removeAllAnimations];
    [UIView animateWithDuration:0.1 animations:^{
        self.navigationController.view.transform =CGAffineTransformMakeTranslation(self.view.bounds.size.width/2, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.navigationController.view.transform =CGAffineTransformMakeTranslation(0, 0);
            self.navigationController.view.alpha =1;
        }];
        //还原到原来的状态
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self layoutNavigationItem];
    [self layoutCinema];
    [self layoutScrollView];
}

-(void)layoutNavigationItem{
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"电影",@"影院"]];
    segment.backgroundColor = [UIColor whiteColor];
    segment.frame =CGRectMake(0, 0, 150, 30);
    segment.tintColor =[UIColor orangeColor];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView =segment;

    UIImage* mapImage = [UIImage imageNamed:@"icon_map"];
    CGRect mapframe = CGRectMake(0,0,20,20);
    UIButton* mapButton= [[UIButton alloc] initWithFrame:mapframe];
    [mapButton setBackgroundImage:mapImage forState:UIControlStateNormal];
    mapButton.titleLabel.font=[UIFont systemFontOfSize:13];
//    [backButton addTarget:self action:@selector(doClickBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mapButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIImage* searchImage = [UIImage imageNamed:@"icon_search"];
    CGRect searchframe = CGRectMake(0,0,20,20);
    UIButton* searchButton= [[UIButton alloc] initWithFrame:searchframe];
    [searchButton setBackgroundImage:searchImage forState:UIControlStateNormal];
    searchButton.titleLabel.font=[UIFont systemFontOfSize:13];
    //    [backButton addTarget:self action:@selector(doClickBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationItem.leftBarButtonItem.customView.hidden =YES;
    self.navigationItem.rightBarButtonItem.customView.hidden =YES;
}

-(void)layoutScrollView{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-108)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth*3, self.view.bounds.size.height-108-44);
    _scrollView.showsVerticalScrollIndicator =NO;
    _scrollView.showsHorizontalScrollIndicator =NO;
    _scrollView.backgroundColor =[UIColor redColor];
    _scrollView.pagingEnabled =YES;
    _scrollView.bounces = NO;
    _scrollView.delegate =self;
    [self.view addSubview:_scrollView];
    
    self.showmoiveController =[[ShowmoiveTableViewController alloc]init];
    self.showmoiveController.tableView.frame =self.scrollView.bounds;
    [self.scrollView addSubview:self.showmoiveController.tableView];
    
    self.willmoiveController =[[WillMovieViewController alloc]init];
    self.willmoiveController.tableView.frame =CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    [self.scrollView addSubview:self.willmoiveController.tableView];
    
    self.topmoiveController =[[TopMovieViewController alloc]init];
    self.topmoiveController.tableView.frame =CGRectMake(self.scrollView.bounds.size.width*2, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    [self.scrollView addSubview:self.topmoiveController.tableView];
    
    self.slideview =[[SlideView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    self.slideview.delegate =self;
    [self.view addSubview:self.slideview];
}

-(void)layoutCinema{
    self.cinemaController =[[CinemaController alloc]init];
    self.cinemaController.tableView.frame =CGRectMake(0, 44, kScreenWidth, self.view.bounds.size.height-64);
    [self.view addSubview:self.cinemaController.tableView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger indexs =  scrollView.contentOffset.x/kScreenWidth;
    NSString *str =[NSString stringWithFormat:@"%ld",indexs];
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"indexs":str}];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

-(void)actionbtIndex:(NSInteger)index{
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(kScreenWidth*index, 0);
    }];
}

#pragma mark -segment事件处理
-(void)segmentAction:(UISegmentedControl *)segment{
    NSInteger scrollindex = [[self.view subviews]indexOfObject:self.scrollView];
    NSInteger cinemaindex = [[self.view subviews]indexOfObject:self.cinemaController.view];
    if (segment.selectedSegmentIndex ==0) {
        self.navigationItem.leftBarButtonItem.customView.hidden =YES;
        self.navigationItem.rightBarButtonItem.customView.hidden =YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.cinemaController.tableView.alpha =0;
            self.scrollView.alpha = 1;

        }];
        [self.view exchangeSubviewAtIndex:scrollindex withSubviewAtIndex:cinemaindex];
    }else if(segment.selectedSegmentIndex ==1){
        self.navigationItem.leftBarButtonItem.customView.hidden =NO;
        self.navigationItem.rightBarButtonItem.customView.hidden =NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.alpha = 0;
            self.cinemaController.tableView.alpha =1;
        }];
        [self.view exchangeSubviewAtIndex:scrollindex withSubviewAtIndex:cinemaindex];
    }
    
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
