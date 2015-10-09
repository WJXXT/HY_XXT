//
//  TitleLabel.m
//  HY_XXT
//
//  Created by XXT on 15/10/9.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "TitleLabel.h"

@implementation TitleLabel

-(void)layoutLabelFrame:(CGFloat)label_y Title:(NSString *)title Font:(UIFont *)font{
    CGSize labelsize = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    self.lineBreakMode = 1;
    self.frame =CGRectMake(10, label_y, labelsize.width, labelsize.height);

    self.text =title;
    self.font =font;
}

@end
