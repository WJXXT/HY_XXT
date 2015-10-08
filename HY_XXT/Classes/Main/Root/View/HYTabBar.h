//
//  HYTabBar.h
//  HY_XXT
//
//  Created by XXT on 15/10/6.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYTabBar;
@protocol HYTabBarDelegate <NSObject>

- (void) tabBar:(HYTabBar *)tabBar selectedFrom:(NSInteger) fromTag to:(NSInteger)toTag;

@end
@interface HYTabBar : UIView
@property(nonatomic,weak) id<HYTabBarDelegate> delegate;
-(void)addButton;
@end
