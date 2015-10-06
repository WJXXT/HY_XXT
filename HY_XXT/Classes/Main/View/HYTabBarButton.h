//
//  HYTabBarButton.h
//  HY_XXT
//
//  Created by XXT on 15/10/6.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kButtonWidht 100
#define kButtonHeight 44
@interface HYTabBarButton : UIButton
-(id)initWithcreateImageNormal:(NSString *)normalImg
                   ImageSelect:(NSString *)selectImg
                          name:(NSString *)name
                         index:(NSInteger)index;
@end
