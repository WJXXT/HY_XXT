//
//  RequstComment.m
//  HY_XXT
//
//  Created by XXT on 15/10/10.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "RequstComment.h"
#import "ActivityComment.h"
@interface RequstComment ()<NSXMLParserDelegate>
@property (nonatomic,copy)NSString *contentStr;//记录读取内容
@property (nonatomic,assign)BOOL isread;
@property (nonatomic,assign)BOOL isMain;
@property (nonatomic,strong)ActivityComment *activityComment;
//@property (nonatomic,strong)NSMutableArray *activityList;
@end
@implementation RequstComment
-(id)init:(NSString *)filestr{
    self =[super init];
    if (self) {
        
        [self quyuData:filestr];
    }
    return self;
}

-(void)quyuData:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:name ofType:@"xml"];
    self.allArr=[NSMutableArray array];
    
    self.isread =NO;
    //读取文件内容
    NSData *parseData = [NSData dataWithContentsOfFile:filePath];
    //创建解析对象
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:parseData];
    //设置代理
    parser.delegate = self;
    //解析
    [parser parse];
}
#pragma mark - SAX解析
//读取到开始标签
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"activity"]) {
        self.activityComment =[ActivityComment new];
    }
}
//获取内容
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    self.contentStr =string;
    self.isread =YES;
}
//读取到结束标签
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (self.isread ==NO) {
        self.contentStr =@"";
    }
    if ([elementName isEqualToString:@"endtime"]) {
        self.activityComment.endtime =self.contentStr;
    }else if ([elementName isEqualToString:@"title"]){
            self.activityComment.title =self.contentStr;
    }else if ([elementName isEqualToString:@"starttime"]){
        self.activityComment.starttime =self.contentStr;
    }else if ([elementName isEqualToString:@"logo"]){
            self.activityComment.logo =self.contentStr;
    }else if ([elementName isEqualToString:@"activityid"]){
        self.activityComment.activityid =self.contentStr;
    }else if ([elementName isEqualToString:@"startdate"]){
        self.activityComment.startdate =self.contentStr;
    }else if ([elementName isEqualToString:@"clickedtimes"]){
        self.activityComment.clickedtimes =self.contentStr;
    }else if ([elementName isEqualToString:@"enddate"]){
        self.activityComment.enddate =self.contentStr;
    }else if ([elementName isEqualToString:@"activity"]){
        [self.allArr addObject:self.activityComment];
    }
    self.isread =NO;
}

@end
