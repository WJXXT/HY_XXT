//
//  ReqShowMoiveData.h
//  HY_XXT
//
//  Created by XXT on 15/10/8.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqShowMoiveData : NSObject
@property (nonatomic,strong)NSMutableArray *allArr;
-(id)init:(NSString *)filestr;
@end
