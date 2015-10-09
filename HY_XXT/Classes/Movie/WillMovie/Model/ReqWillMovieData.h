//
//  ReqWillMovieData.h
//  
//
//  Created by 王新国 on 15/10/10.
//
//

#import <Foundation/Foundation.h>

@interface ReqWillMovieData : NSObject
@property (nonatomic,strong)NSMutableArray *allArr;
-(id)init:(NSString *)filestr;
@end
