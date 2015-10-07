//
//  DropButton.m
//  
//
//  Created by 王新国 on 15/10/8.
//
//

#import "DropButton.h"

@implementation DropButton
-(id)initWithFrame:(CGRect)frame Title:(NSString *)title{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        [self setImage:nil forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"ssdk_auth_title_back"] forState:UIControlStateSelected];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        self.titleLabel.font =[UIFont boldSystemFontOfSize:15];
        self.titleLabel.textAlignment= 1;
    }
    return self;
}
#pragma mark 设置Button内部的image的范围
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
        [super imageRectForContentRect:contentRect];
    CGFloat imageW = contentRect.size.width * 0.03;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(0, 0, imageW, imageH);
}
#pragma mark 设置Button内部的title的范围
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
        [super titleRectForContentRect:contentRect];
    CGFloat titleX = contentRect.size.width *0.1;
//    CGFloat titleY = contentRect.size.height;
    CGFloat titleW = contentRect.size.width *0.9;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, 0, titleW, titleH);
}
/**什么也不做就可以取消系统按钮的高亮状态*/
- (void)setHighlighted:(BOOL)highlighted{
    //    [super setHighlighted:highlighted];
}

@end
