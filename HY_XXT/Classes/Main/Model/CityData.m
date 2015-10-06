//
//  CityData.m
//  HY_XXT
//
//  Created by XXT on 15/10/6.
//  Copyright (c) 2015年 XXT. All rights reserved.s
//

#import "CityData.h"

@implementation CityData
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    if ([key isEqualToString:@"areasarr"]) {
        self.areasarr =value;
    }
}
@end
