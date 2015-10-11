//
//  RequestAdvert.m
//  HY_XXT
//
//  Created by XXT on 15/10/10.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "RequestAdvert.h"
#import "AdvertData.h"
#import "AdvertisingData.h"
@interface RequestAdvert ()<NSXMLParserDelegate>
@property (nonatomic,copy)NSString *contentStr;//记录读取内容
@property (nonatomic,assign)BOOL isread;
@property (nonatomic,assign)BOOL isMain;
@property (nonatomic,strong)AdvertisingData *advertising;
@property (nonatomic,strong)AdvertData *advert;
@property (nonatomic,strong)NSMutableArray *advertisingList;
@property (nonatomic,strong)NSMutableArray *advertList;
@end
@implementation RequestAdvert
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
    if ([elementName isEqualToString:@"advertising"]) {
        self.advertising =[AdvertisingData new];
    }else if([elementName isEqualToString:@"advert"]){
        self.advert=[AdvertData new];
    }else if([elementName isEqualToString:@"advertisingList"]){
        self.advertisingList=[NSMutableArray array];
        self.isMain =YES;
    }else if([elementName isEqualToString:@"advertList"]){
        self.advertList=[NSMutableArray array];
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
    if ([elementName isEqualToString:@"relatedId"]) {
        self.advertising.relatedId =self.contentStr;
    }else if ([elementName isEqualToString:@"link"]){
        if (self.isMain) {
            self.advertising.link =self.contentStr;
        }else{
            self.advert.link =self.contentStr;
        }
    }else if ([elementName isEqualToString:@"advlogo"]){
        if (self.isMain) {
            self.advertising.advlogo =self.contentStr;
        }else{
            self.advert.advlogo =self.contentStr;
        }
    }else if ([elementName isEqualToString:@"endTime"]){
        self.advertising.endTime =self.contentStr;
    }else if ([elementName isEqualToString:@"title"]){
        if (self.isMain) {
            self.advertising.title =self.contentStr;
        }else{
            self.advert.title =self.contentStr;
        }
    }else if ([elementName isEqualToString:@"startTime"]){
        self.advertising.startTime =self.contentStr;
    }else if ([elementName isEqualToString:@"type"]){
        self.advertising.type =self.contentStr;
    }else if ([elementName isEqualToString:@"summary"]){
        self.advert.summary =self.contentStr;
    }else if ([elementName isEqualToString:@"addtime"]){
        self.advert.addtime =self.contentStr;
    }else if ([elementName isEqualToString:@"sdlogo"]){
        self.advert.sdlogo =self.contentStr;
    }else if ([elementName isEqualToString:@"relatedid"]){
        self.advert.relatedid =self.contentStr;
    }else if ([elementName isEqualToString:@"advertisingList"]){
        [self.allArr addObject:self.advertisingList];
    }else if ([elementName isEqualToString:@"advertList"]){
        [self.allArr addObject:self.advertList];
    }else if ([elementName isEqualToString:@"advertising"]){
        [self.advertisingList addObject:self.advertising];
    }else if ([elementName isEqualToString:@"advert"]){
        [self.advertList addObject:self.advert];
    }
    self.isread =NO;
}
@end
