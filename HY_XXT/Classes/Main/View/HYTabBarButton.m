//
//  HYTabBarButton.m
//  HY_XXT
//
//  Created by XXT on 15/10/6.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "HYTabBarButton.h"

@implementation HYTabBarButton

-(id)initWithcreateImageNormal:(NSString *)normalImg ImageSelect:(NSString *)selectImg name:(NSString *)name index:(NSInteger)index{
    self =[super init];
    if (self) {
        //加入下行,无法进入imageRectForContentRect等方法
        //        self =[UIButton buttonWithType:UIButtonTypeCustom];
        //    TbCustomButton *button =[[UIButton alloc]init]
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        if (index == 0) {
            self.frame =CGRectMake(kButtonWidht/2*index, 0, kButtonWidht, kButtonHeight);
        }else{
            self.frame =CGRectMake(kButtonWidht/2*index+50, 0, kButtonWidht, kButtonHeight);
        }

        self.backgroundColor =[UIColor whiteColor];
        [self setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:selectImg] forState:UIControlStateSelected];
        [self setTitle:name forState:UIControlStateNormal];
        self.titleLabel.font =[UIFont boldSystemFontOfSize:15];
        self.tag =101+index;
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self setTintColor:[UIColor redColor]];
        //        self.imageView.contentMode = UIViewContentModeCenter; // 让图片在按钮内居中
        if (index == 0) {
            self.selected = YES;
        }
    }
    return self;
}
#pragma mark 设置Button内部的image的范围
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    //    [super imageRectForContentRect:contentRect];
    CGFloat titleX = contentRect.size.width *0;
    CGFloat imageW = contentRect.size.width * 0.6;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(titleX, 0, imageW, imageH);
}
#pragma mark 设置Button内部的title的范围
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    //    [super titleRectForContentRect:contentRect];
    CGFloat titleX = contentRect.size.width *0.45;
    CGFloat titleY = contentRect.size.height *0.1;
    CGFloat titleW = contentRect.size.width *0.6;
    CGFloat titleH = contentRect.size.height *0.8;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
/**什么也不做就可以取消系统按钮的高亮状态*/
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
}


@end
