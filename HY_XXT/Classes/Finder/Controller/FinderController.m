//
//  FinderController.m
//  HY_XXT
//
//  Created by XXT on 15/10/6.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "FinderController.h"
#import "AFNReuest.h"
#import "CityController.h"
@interface FinderController ()
@property (nonatomic,assign)NSInteger citySelet;
@end

@implementation FinderController
-(void)viewWillAppear:(BOOL)animated{
    self.view.alpha =0;
    [self.view.layer removeAllAnimations];
    [UIView animateWithDuration:0.1 animations:^{
        self.view.transform =CGAffineTransformMakeTranslation(self.view.bounds.size.width/2, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.transform =CGAffineTransformMakeTranslation(0, 0);
            self.view.alpha =1;
        }];

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _citySelet = 1;

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (_citySelet == 1) {
        CityController *cityer =[[CityController alloc]init];
        UINavigationController *naVc= [[UINavigationController alloc]initWithRootViewController:cityer];
        [self presentViewController:naVc animated:YES completion:nil];
        _citySelet =0;
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
