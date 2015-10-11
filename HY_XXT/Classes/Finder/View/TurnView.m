//
//  TurnView.m
//  
//
//  Created by 王新国 on 15/10/11.
//
//

#import "TurnView.h"
#import "AdvertisingData.h"
#import "UIImageView+WebCache.h"
@interface TurnView ()<UIScrollViewDelegate>
//-(id)initWithFrame:(CGRect)frame Data:(NSMutableArray *)arr;
@end
@implementation TurnView
-(id)initWithFrame:(CGRect)frame Data:(NSMutableArray *)arr{
    self =[super initWithFrame:frame];
    if (self) {
        self.contentSize =CGSizeMake(frame.size.width*arr.count, frame.size.height);
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.pagingEnabled =YES;
        for (int i = 0; i<arr.count; i++) {
            AdvertisingData *data =arr[i];
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width*i+14, 0, frame.size.width, frame.size.height)];
            imageView.tag = i+200;
            [imageView sd_setImageWithURL:[NSURL URLWithString:data.advlogo]];
                imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:imageView];
        }
    }
    return self;
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView*)scrollView{
    NSLog(@"dsa");
}
@end
