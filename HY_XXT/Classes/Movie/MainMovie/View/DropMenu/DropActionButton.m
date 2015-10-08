//
//  DropActionButton.m
//  HY_XXT
//
//  Created by XXT on 15/10/8.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "DropActionButton.h"
#import "DropDownMenuView.h"

@interface DropActionButton ()

@end

@implementation DropActionButton

-(id)initWithCreateImageNormal:(NSString *)normalImg ImageSelect:(NSString *)selectImg name:(NSString *)name Frame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor =[UIColor whiteColor];
        [self setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:selectImg] forState:UIControlStateSelected];
        [self setTitle:name forState:UIControlStateNormal];
        self.titleLabel.font =[UIFont boldSystemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}
#pragma mark 设置Button内部的image的范围
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    //    [super imageRectForContentRect:contentRect];
    CGFloat titleX = contentRect.size.width *0.8;
    CGFloat imageW = contentRect.size.width * 0.2;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(titleX, 0, imageW, imageH);
}
#pragma mark 设置Button内部的title的范围
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    //    [super titleRectForContentRect:contentRect];


    CGFloat titleW = contentRect.size.width *0.8;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(0, 0, titleW, titleH);
}
/**什么也不做就可以取消系统按钮的高亮状态*/
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected ==YES) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.layer.transform =CATransform3DMakeRotation(M_PI, 1, 0, 0);;
        }];

    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.layer.transform =CATransform3DMakeRotation(M_PI*2, 1, 0, 0);;
        }];
    }
}


@end
