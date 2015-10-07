//
//  MoviesData.h
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DealsData.h"
@interface MoviesData :NSObject
@property (nonatomic,copy) NSString *feature;
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *bus;
@property (nonatomic,retain) NSMutableArray *dealsarr;
@property (nonatomic,copy) NSNumber *imax;
@property (nonatomic,copy) NSNumber *lng;
@property (nonatomic,copy) NSNumber *sellPrice;
@property (nonatomic,copy) NSString *nm;
@property (nonatomic,copy) NSString *dis;
@property (nonatomic,copy) NSNumber *areaId;
@property (nonatomic,copy) NSNumber *ctid;
@property (nonatomic,copy) NSString *ct;
@property (nonatomic,copy) NSString *park;
@property (nonatomic,copy) NSNumber *deal;
@property (nonatomic,copy) NSNumber *ID;
@property (nonatomic,copy) NSNumber *dealPrice;
@property (nonatomic,copy) NSNumber *referencePrice;
@property (nonatomic,copy) NSString *suw;
@property (nonatomic,copy) NSString *brd;
@property (nonatomic,copy) NSString *note;
@property (nonatomic,copy) NSString *area;
@property (nonatomic,copy) NSNumber *lat;
@property (nonatomic,copy) NSNumber *sell;
@property (nonatomic,copy) NSString *addr;
@property (nonatomic,copy) NSString *dri;
@end
