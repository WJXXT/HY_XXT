//
//  SlideView.h
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SlideView;

@protocol SlideViewDelegate <NSObject>

- (void)actionbtIndex:(NSInteger) index;

@end
@interface SlideView : UIView
@property (nonatomic,weak)id<SlideViewDelegate>delegate;
-(id)initWithFrame:(CGRect)frame;

@end
