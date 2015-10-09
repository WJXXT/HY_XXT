//
//  CommonData.m
//  HY_XXT
//
//  Created by XXT on 15/10/9.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "CommonData.h"
#import "MovieIcon.h"
@implementation CommonData
+(NSArray *)movieIconData{
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"影效" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    NSLog(@"%@",dic);
    NSMutableArray *arr =[NSMutableArray array];
    NSArray *movieIcon = [dic valueForKey:@"movieIconList"];
    for (NSDictionary *dic in movieIcon) {
        MovieIcon *data =[MovieIcon new];
        data.edition =[dic valueForKey:@"edition"];
        NSDictionary *icon = [dic valueForKey:@"iconUrl"];
        data.imgIcon = [icon valueForKey:@"imgIcon"];
        data.imgWight = [icon valueForKey:@"imgWight"];
        data.imgHeight = [icon valueForKey:@"imgHeight"];
        [arr addObject:data];
    }
//    NSLog(@"%@",arr);
    return arr;
}
@end
