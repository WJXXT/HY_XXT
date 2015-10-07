//
//  SlideButton.m
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "SlideButton.h"

@implementation SlideButton

-(id)initWithCreatename:(NSString *)name index:(NSInteger)index{
    self =[super init];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.frame =CGRectMake(kScreenWidth/3*index, 0, kScreenWidth/3, 44);
        self.backgroundColor =[UIColor whiteColor];
        [self setTitle:name forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        self.titleLabel.font =[UIFont boldSystemFontOfSize:15];
        self.index =index;
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted{
//        [super setHighlighted:highlighted];
}
@end
