//
//  RequsetCinema.h
//  HY_XXT
//
//  Created by XXT on 15/10/9.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequsetCinema : NSObject
@property (nonatomic,strong)NSMutableArray *allArr;
-(id)init:(NSString *)filestr;
@end
