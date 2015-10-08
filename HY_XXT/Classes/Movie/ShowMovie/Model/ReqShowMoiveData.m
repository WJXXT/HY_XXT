//
//  ReqShowMoiveData.m
//  HY_XXT
//
//  Created by XXT on 15/10/8.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "ReqShowMoiveData.h"

@implementation ReqShowMoiveData
+(NSArray *)reaqustFile:(NSString *)fileName {
    //创建字典 承装解析后的数据
    //    1.获取文件路径
    NSString *filePath =[[NSBundle mainBundle]pathForResource:fileName ofType:@"xml"];
    //    2.读取文件内容
    NSString *parseStr =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //    3.将需要解析的内容读入document
    GDataXMLDocument *document =[[GDataXMLDocument alloc]initWithXMLString:parseStr options:0 error:nil];
    //    4.获取根节点
    GDataXMLElement *rootElement =[document rootElement];
    ////    获取子节点
        NSArray *elments = [rootElement elementsForName:@"movieList"];
//    NSArray *arr=[elments valueForKey:@"movieList"];
//        GDataXMLElement *status = [elments firstObject];
//     NSString *arr=[status valueForKey:@"movie"];
    //    NSString *statusValue =[status stringValue];
    //    NSLog(@"%@",statusValue);
//    NSArray *elements =[rootElement elementsForName:@"categories"];
//    for (GDataXMLElement *element in elements) {
//        //获取下一级的子节点们
//        NSArray *names =[element elementsForName:@"category_name"];
//        NSArray *subcategories = [element elementsForName:@"subcategories"];
//        //        获取叶子节点的值
//        NSString *categoryName = [[names firstObject] stringValue];
//        //        创建对应分组
//        NSMutableArray *group = [NSMutableArray array];
//        //        将分组放入字典
//        [_categoryDic setValue:group forKey:categoryName];
//        for (GDataXMLElement *element in subcategories) {
//            //获取叶子节点的值
//            NSString *subStr = [element stringValue];
//            NSLog(@"%@",subStr);
//            [group addObject:subStr];
//        }
//    }
    return elments;
}
@end
