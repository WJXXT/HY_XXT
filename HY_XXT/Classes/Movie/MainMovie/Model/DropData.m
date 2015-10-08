//
//  DropData.m
//  HY_XXT
//
//  Created by XXT on 15/10/8.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "DropData.h"
#import "DropCityData.h"
#import "DropSubwayData.h"
#import "DropAreaData.h"
@interface DropData ()<NSXMLParserDelegate>
@property (nonatomic,copy)NSString *contentStr;//记录读取内容
@property (nonatomic,strong)NSMutableArray *xmlArr;
@property (nonatomic,copy)NSString *num;

@property (nonatomic,strong)DropCityData *city;
@property (nonatomic,strong)DropAreaData *area;
@property (nonatomic,strong)DropSubwayData *subway;
@end
@implementation DropData

-(id)init:(NSArray *)filearr{
    self =[super init];
    if (self) {
        self.allDic =[NSMutableDictionary dictionary];
        for (NSString *key in filearr) {
            [self quyuData:key];
        }
    }
    return self;
}

//-(void)requsetData{
//    NSArray *allkey =[NSArray arrayWithObjects:@"city",@"subway",@"area",nil];
//    [self quyuData:@"city"];
//    [self quyuData:@"area"];
//    [self quyuData:@"subway"];
//}

-(void)quyuData:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:name ofType:@"xml"];
    self.xmlArr=[NSMutableArray array];
    //读取文件内容
    NSData *parseData = [NSData dataWithContentsOfFile:filePath];
    //创建解析对象
    NSXMLParser *parser = [[NSXMLParser alloc]initWithData:parseData];
    //设置代理
    parser.delegate = self;
    //解析
    [parser parse];
    
    //进行数据处理
    [self.allDic setValue:self.xmlArr forKey:name];
//    NSLog(@"%@",self.xmlArr);
}
#pragma mark - SAX解析
//读取到开始标签
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"county"]) {
        self.city =[DropCityData new];
    }else if ([elementName isEqualToString:@"indexarea"]) {
        self.area =[DropAreaData new];
    }else if ([elementName isEqualToString:@"subway"]) {
        self.subway =[DropSubwayData new];
    }
}
//获取内容
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    self.num= self.contentStr;
    self.contentStr =string;
}
//读取到结束标签
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if ([elementName isEqualToString:@"countycode"]) {
        self.city.countycode =self.contentStr;
    }else if ([elementName isEqualToString:@"countyname"]){
        self.city.countyname =self.contentStr;
        self.city.name =self.contentStr;
    }else if ([elementName isEqualToString:@"briefname"]){
        self.city.briefname =self.contentStr;
    }else if ([elementName isEqualToString:@"county"]){
        [self.xmlArr addObject:self.city];
    }
    
    else if ([elementName isEqualToString:@"indexareacode"]){
        self.area.indexareacode =self.contentStr;
    }else if ([elementName isEqualToString:@"indexareaname"]){
        self.area.indexareaname =self.contentStr;
        self.area.name =self.contentStr;
    }else if ([elementName isEqualToString:@"indexarea"]){
        [self.xmlArr addObject:self.area];
    }
    
    else if ([elementName isEqualToString:@"subwayid"]){
        self.subway.subwayid =self.contentStr;
    }else if ([elementName isEqualToString:@"subwayname"]){
        if ([self.contentStr isEqual:@"号线"]) {
            NSString *str =[NSString stringWithFormat:@"%@%@",self.num,self.contentStr];
            self.subway.subwayname = str;
            self.subway.name = str;
        }else{
            self.subway.subwayname = self.contentStr;
            self.subway.name = self.contentStr;
        }
    }else if ([elementName isEqualToString:@"subway"]){
        [self.xmlArr addObject:self.subway];
    }
    
}

@end
