//
//  ChartImageView.m
//  
//
//  Created by 王新国 on 15/10/9.
//
//

#import "ChartImageView.h"
#import "UIImageView+WebCache.h"
@implementation ChartImageView
-(void)addImageView:(NSArray *)data{
    while (self.subviews.firstObject) {
        [self.subviews.firstObject removeFromSuperview];
    }
    
    CGFloat iconX = 0;
    for (int i = 0; i < data.count; i++) {
        DesceiphionData *icon =data[i];
        CGFloat wight =[icon.imgWight floatValue]/2;
        CGFloat height =[icon.imgHeight floatValue]/2;
        UIImageView *characteristicIcon =[[UIImageView alloc]initWithFrame:CGRectMake(iconX, 0, wight, height)];
        [characteristicIcon sd_setImageWithURL:[NSURL URLWithString:icon.imgIcon]];
        [self addSubview:characteristicIcon];
        iconX =iconX +wight+5;
        if (iconX > self.bounds.size.width) {
            return;
        }
    }
}
@end
