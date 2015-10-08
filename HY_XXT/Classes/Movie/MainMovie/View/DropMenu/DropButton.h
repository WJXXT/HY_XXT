//
//  DropButton.h
//  
//
//  Created by 王新国 on 15/10/8.
//
//

#import <UIKit/UIKit.h>

@interface DropButton : UIButton
@property (nonatomic,strong)NSArray *arrdata;
-(id)initWithFrame:(CGRect)frame
             Title:(NSString *)title;
@end
