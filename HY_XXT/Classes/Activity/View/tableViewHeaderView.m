//
//  tableViewHeaderView.m
//  HY_XXT
//
//  Created by XXT on 15/10/10.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "tableViewHeaderView.h"
#import "HeaderButton.h"
@implementation tableViewHeaderView

-(void)layoutHeaderView{
    self.backgroundColor =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    UIView *view =[[UIView alloc]initWithFrame:self.frame];
    view.backgroundColor =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];

    [self addSubview:view];
    HeaderButton *view1 =[[HeaderButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2-2, self.frame.size.height)];
    [view1 layoutButtonIndex:1];
    HeaderButton *view2 =[[HeaderButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 0,self.frame.size.width/2, self.frame.size.height/2-2)];
    [view2 layoutButtonIndex:2];
    HeaderButton *view3 =[[HeaderButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height/2,self.frame.size.width/4-2, self.frame.size.height/2)];
    [view3 layoutButtonIndex:3];
    HeaderButton *view4 =[[HeaderButton alloc]initWithFrame:CGRectMake(self.frame.size.width/4*3, self.frame.size.height/2,self.frame.size.width/4, self.frame.size.height/2)];
    [view4 layoutButtonIndex:4];
    [view addSubview:view1];
    [view addSubview:view2];
    [view addSubview:view3];
    [view addSubview:view4];
                                                                           
                                                                           
}



@end
