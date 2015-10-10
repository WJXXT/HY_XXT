//
//  RequstMain.m
//  HY_XXT
//
//  Created by XXT on 15/10/10.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "RequstMain.h"
#import "ActivityMain.h"
#import "QueryCommend.h"

@interface RequstMain ()<NSXMLParserDelegate>
@property (nonatomic,copy)NSString *contentStr;//记录读取内容
@property (nonatomic,assign)BOOL isread;
@property (nonatomic,assign)BOOL isMain;
@property (nonatomic,strong)ActivityMain *activityMain;
@property (nonatomic,strong)QueryCommend *queryCommend;
@property (nonatomic,strong)NSMutableArray *activityList;
@property (nonatomic,strong)NSMutableArray *queryCommendList;
@end
@implementation RequstMain
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
        self.activityMain =[ActivityMain new];
    }else if([elementName isEqualToString:@"queryCommend"]){
        self.queryCommend=[QueryCommend new];
    }else if([elementName isEqualToString:@"activityList"]){
        self.activityList=[NSMutableArray array];
        self.isMain =YES;
    }else if([elementName isEqualToString:@"queryCommendList"]){
        self.queryCommendList=[NSMutableArray array];
        self.isMain=NO;
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
    if ([elementName isEqualToString:@"activityid"]) {
        self.activityMain.activityid =self.contentStr;
    }else if ([elementName isEqualToString:@"title"]){
        if (self.isMain) {
            self.activityMain.title =self.contentStr;
        }else{
            self.queryCommend.title =self.contentStr;
        }
    }else if ([elementName isEqualToString:@"mobileUrl"]){
        self.activityMain.mobileUrl =self.contentStr;
    }else if ([elementName isEqualToString:@"logo"]){
        if (self.isMain) {
            self.activityMain.logo =self.contentStr;
        }else{
            self.queryCommend.logo =self.contentStr;
        }
    }else if ([elementName isEqualToString:@"signname"]){
        self.queryCommend.signname =self.contentStr;
    }else if ([elementName isEqualToString:@"deslogo"]){
        self.queryCommend.deslogo =self.contentStr;
    }else if ([elementName isEqualToString:@"summary"]){
        self.queryCommend.summary =self.contentStr;
    }else if ([elementName isEqualToString:@"activityList"]){
        [self.allArr addObject:self.activityList];
    }else if ([elementName isEqualToString:@"queryCommendList"]){
        [self.allArr addObject:self.queryCommendList];
    }else if ([elementName isEqualToString:@"activity"]){
            [self.activityList addObject:self.activityMain];
    }else if ([elementName isEqualToString:@"queryCommend"]){
        [self.queryCommendList addObject:self.queryCommend];
    }
    self.isread =NO;
}

@end
