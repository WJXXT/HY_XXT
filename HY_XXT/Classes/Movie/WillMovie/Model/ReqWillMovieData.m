//
//  ReqWillMovieData.m
//  
//
//  Created by 王新国 on 15/10/10.
//
//

#import "ReqWillMovieData.h"
#import "WillMovieData.h"
#import "StrForDic.h"
@interface ReqWillMovieData ()<NSXMLParserDelegate>
@property (nonatomic,copy)NSString *contentStr;//记录读取内容
@property (nonatomic,assign)BOOL isread;
@property (nonatomic,assign)BOOL isHot;
@property (nonatomic,strong)WillMovieData *willMovie;
@property (nonatomic,strong)NSMutableArray *hotMovie;
@property (nonatomic,strong)NSMutableArray *normlMovie;
@end
@implementation ReqWillMovieData
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
        self.willMovie =[WillMovieData new];
    }else if([elementName isEqualToString:@"hotMovieList"]){
        self.hotMovie=[NSMutableArray array];
        self.isHot =YES;
    }else if([elementName isEqualToString:@"movieList"]){
        self.normlMovie=[NSMutableArray array];
        self.isHot=NO;
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
        self.willMovie.moviename =self.contentStr;
    }else if ([elementName isEqualToString:@"releasedate"]){
        self.willMovie.releasedate =self.contentStr;
    }else if ([elementName isEqualToString:@"releasedateDescForList"]){
        self.willMovie.releasedateDescForList =self.contentStr;
    }else if ([elementName isEqualToString:@"highlight"]){
        self.willMovie.highlight =self.contentStr;
    }else if ([elementName isEqualToString:@"countdes"]){
        self.willMovie.countdes =self.contentStr;
    }else if ([elementName isEqualToString:@"hlogo"]){
        self.willMovie.hlogo =self.contentStr;
    }else if ([elementName isEqualToString:@"icon"]){
        self.willMovie.icon =[StrForDic dictionaryWithJsonString:self.contentStr];
    }else if ([elementName isEqualToString:@"actors"]){
        self.willMovie.actors =self.contentStr;
    }else if ([elementName isEqualToString:@"englishname"]){
        self.willMovie.englishname =self.contentStr;
    }else if ([elementName isEqualToString:@"logo"]){
        self.willMovie.logo =self.contentStr;
    }else if ([elementName isEqualToString:@"gcedition"]){
        self.willMovie.gcedition =self.contentStr;
    }else if ([elementName isEqualToString:@"label"]){
        self.willMovie.label =self.contentStr;
    }else if ([elementName isEqualToString:@"director"]){
        self.willMovie.director =self.contentStr;
    }else if ([elementName isEqualToString:@"presell"]){
        self.willMovie.presell =self.contentStr;
    }else if ([elementName isEqualToString:@"xiangkan"]){
        self.willMovie.xiangkan =self.contentStr;
    }else if ([elementName isEqualToString:@"generalmark"]){
        self.willMovie.generalmark =self.contentStr;
    }else if ([elementName isEqualToString:@"minprice"]){
        self.willMovie.minprice =self.contentStr;
    }else if ([elementName isEqualToString:@"language"]){
        self.willMovie.language =self.contentStr;
    }else if ([elementName isEqualToString:@"hotMovieList"]){
        [self.allArr addObject:self.hotMovie];
    }else if ([elementName isEqualToString:@"movieList"]){
        [self.allArr addObject:self.normlMovie];
    }else if ([elementName isEqualToString:@"movie"]){
        if (self.isHot) {
            [self.hotMovie addObject:self.willMovie];
        }else{
            [self.normlMovie addObject:self.willMovie];
        }
    }
    self.isread =NO;
}

@end
