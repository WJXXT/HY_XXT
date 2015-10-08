//
//  DropActionButton.h
//  HY_XXT
//
//  Created by XXT on 15/10/8.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropActionButton : UIButton
//@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSArray *arr;
-(id)initWithCreateImageNormal:(NSString *)normalImg ImageSelect:(NSString *)selectImg name:(NSString *)name Frame:(CGRect)frame;
@end
