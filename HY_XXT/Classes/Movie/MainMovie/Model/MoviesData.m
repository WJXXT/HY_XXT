//
//  MoviesData.m
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "MoviesData.h"

@implementation MoviesData
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"deals"]) {
        self.dealsarr =[NSMutableArray array];
        for (NSDictionary *dic in value) {
            DealsData *data =[DealsData new];
            [data setValuesForKeysWithDictionary:dic];
            [self.dealsarr addObject:data];
        }

    }
}
@end
