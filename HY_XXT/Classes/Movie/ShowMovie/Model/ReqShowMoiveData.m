//
//  ReqShowMoiveData.m
//  HY_XXT
//
//  Created by XXT on 15/10/8.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "ReqShowMoiveData.h"
#import "ShowMoiveData.h"
#import "StrForDic.h"
@interface ReqShowMoiveData ()<NSXMLParserDelegate>
@property (nonatomic,copy)NSString *contentStr;//记录读取内容
@property (nonatomic,assign)BOOL isread;
@property (nonatomic,strong)ShowMoiveData *showMovie;

@end
@implementation ReqShowMoiveData
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
    if ([elementName isEqualToString:@"movie"]) {
        self.showMovie =[ShowMoiveData new];
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
    if ([elementName isEqualToString:@"moviename"]) {
        self.showMovie.moviename =self.contentStr;
    }else if ([elementName isEqualToString:@"releasedate"]){
        self.showMovie.releasedate =self.contentStr;
    }else if ([elementName isEqualToString:@"highlight"]){
        self.showMovie.highlight =self.contentStr;
    }else if ([elementName isEqualToString:@"countdes"]){
        self.showMovie.countdes =self.contentStr;
    }else if ([elementName isEqualToString:@"hlogo"]){
        self.showMovie.hlogo =self.contentStr;
    }else if ([elementName isEqualToString:@"icon"]){
        self.showMovie.icon =[StrForDic dictionaryWithJsonString:self.contentStr];
    }else if ([elementName isEqualToString:@"actors"]){
        self.showMovie.actors =self.contentStr;
    }else if ([elementName isEqualToString:@"englishname"]){
        self.showMovie.englishname =self.contentStr;
    }else if ([elementName isEqualToString:@"logo"]){
        self.showMovie.logo =self.contentStr;
    }else if ([elementName isEqualToString:@"gcedition"]){
        self.showMovie.gcedition =self.contentStr;
    }else if ([elementName isEqualToString:@"label"]){
        self.showMovie.label =self.contentStr;
    }else if ([elementName isEqualToString:@"director"]){
        self.showMovie.director =self.contentStr;
    }else if ([elementName isEqualToString:@"presell"]){
        self.showMovie.presell =self.contentStr;
    }else if ([elementName isEqualToString:@"generalmark"]){
        self.showMovie.generalmark =self.contentStr;
    }else if ([elementName isEqualToString:@"minprice"]){
        self.showMovie.minprice =self.contentStr;
    }else if ([elementName isEqualToString:@"language"]){
        self.showMovie.language =self.contentStr;
    }else if ([elementName isEqualToString:@"movie"]){
        [self.allArr addObject:self.showMovie];
    }
    self.isread =NO;
}
@end
