//
//  SlideButton.h
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideButton : UIButton
-(id)initWithCreatename:(NSString *)name index:(NSInteger)index;
@property(nonatomic,assign)NSInteger index;
@end
