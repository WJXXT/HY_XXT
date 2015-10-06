//
//  ActivityController.m
//  HY_XXT
//
//  Created by XXT on 15/10/6.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "ActivityController.h"

@interface ActivityController ()

@end

@implementation ActivityController
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
        //还原到原来的状态
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
