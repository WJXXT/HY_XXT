//
//  RequsetCinema.m
//  HY_XXT
//
//  Created by XXT on 15/10/9.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "RequsetCinema.h"
#import "CinemaData.h"
#import "StrForDic.h"
#import "DesceiphionData.h"
@interface RequsetCinema ()<NSXMLParserDelegate>

@property (nonatomic,copy)NSString *contentStr;//记录读取内容
@property (nonatomic,assign)BOOL isread;
@property (nonatomic,strong)CinemaData *showCinema;
@end
@implementation RequsetCinema
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
    if ([elementName isEqualToString:@"cinema"]) {
        self.showCinema =[CinemaData new];
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
    if ([elementName isEqualToString:@"myCinema"]) {
        self.showCinema.myCinema =self.contentStr;
    }else if ([elementName isEqualToString:@"pointx"]){
        self.showCinema.pointx =self.contentStr;
    }else if ([elementName isEqualToString:@"citycode"]){
        self.showCinema.citycode =self.contentStr;
    }else if ([elementName isEqualToString:@"countdes"]){
        self.showCinema.countdes =self.contentStr;
    }else if ([elementName isEqualToString:@"pointy"]){
        self.showCinema.pointy =self.contentStr;
    }else if ([elementName isEqualToString:@"icon"]){
        NSArray *arr =[StrForDic dictionaryWithJsonString:self.contentStr];
        NSMutableArray *dataarr =[NSMutableArray array];
        for (NSDictionary *dic in arr) {
            DesceiphionData *data =[DesceiphionData new];
            [data setValuesForKeysWithDictionary:dic];
            [dataarr addObject:data];
        }
        self.showCinema.icon =[[NSArray alloc]initWithArray:dataarr];
    }else if ([elementName isEqualToString:@"countdes"]){
        self.showCinema.countdes =self.contentStr;
    }else if ([elementName isEqualToString:@"cinemaname"]){
        self.showCinema.cinemaname =self.contentStr;
    }else if ([elementName isEqualToString:@"logo"]){
        self.showCinema.logo =self.contentStr;
    }else if ([elementName isEqualToString:@"bpointx"]){
        self.showCinema.bpointx =self.contentStr;
    }else if ([elementName isEqualToString:@"bpointy"]){
        self.showCinema.bpointy =self.contentStr;
    }else if ([elementName isEqualToString:@"address"]){
        self.showCinema.address =self.contentStr;
    }else if ([elementName isEqualToString:@"generalmark"]){
        self.showCinema.generalmark =self.contentStr;
    }else if ([elementName isEqualToString:@"characteristic"]){
        self.showCinema.characteristic =self.contentStr;
    }else if ([elementName isEqualToString:@"characteristicIcon"]){
        self.showCinema.characteristicIcon =[StrForDic dictionaryWithJsonString:self.contentStr];
    }else if ([elementName isEqualToString:@"cinema"]){
        [self.allArr addObject:self.showCinema];
    }
    self.isread =NO;
}
@end
