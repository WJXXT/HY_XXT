//
//  CinemaController.m
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "CinemaController.h"
#import "DropDownMenuView.h"

@interface CinemaController ()<NSXMLParserDelegate>
@property (nonatomic ,copy)NSString *contentStr;//记录读取内容
@property (nonatomic,strong)NSMutableDictionary *xmlDic;
@property (nonatomic,strong)NSMutableArray *xmlArr;
@property (nonatomic,strong)NSMutableDictionary *allDic;
@property (nonatomic,copy)NSString *num;
@end

@implementation CinemaController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allDic =[NSMutableDictionary dictionary];
    NSArray *allkey =[NSArray arrayWithObjects:@"city",@"subway",@"area",nil];
    [self quyuData:@"city"];
    [self quyuData:@"area"];
    [self quyuData:@"subway"];
    DropDownMenuView *dropView =[[DropDownMenuView alloc]initWithHeight:64 DataDic:self.allDic AllKey:allkey];
    [self.tableView addSubview:dropView];
}

-(void)quyuData:(NSString *)name{
    NSString *filePath = [[NSBundle mainBundle]pathForResource:name ofType:@"xml"];
    self.xmlArr =[NSMutableArray array];
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
}
#pragma mark - SAX解析
//读取到开始标签
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"county"]||[elementName isEqualToString:@"indexarea"]||[elementName isEqualToString:@"subway"]) {
        self.xmlDic =[NSMutableDictionary dictionary];
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
            [self.xmlDic setValue:self.contentStr forKey:@"countycode"];
        }else if ([elementName isEqualToString:@"countyname"]){
            [self.xmlDic setValue:self.contentStr forKey:@"name"];
        }else if ([elementName isEqualToString:@"briefname"]){
            [self.xmlDic setValue:self.contentStr forKey:@"briefname"];
        }else if ([elementName isEqualToString:@"county"]){
            [self.xmlArr addObject:self.xmlDic];
        }
    
         else if ([elementName isEqualToString:@"indexareacode"]){
            [self.xmlDic setValue:self.contentStr forKey:@"indexareacode"];
        }else if ([elementName isEqualToString:@"indexareaname"]){
            [self.xmlDic setValue:self.contentStr forKey:@"name"];
        }else if ([elementName isEqualToString:@"indexarea"]){
            [self.xmlArr addObject:self.xmlDic];
        }
    
         else if ([elementName isEqualToString:@"subwayid"]){
            [self.xmlDic setValue:self.contentStr forKey:@"subwayid"];
        }else if ([elementName isEqualToString:@"subwayname"]){
            if ([self.contentStr isEqual:@"号线"]) {
                NSString *str =[NSString stringWithFormat:@"%@%@",self.num,self.contentStr];
                [self.xmlDic setValue:str forKey:@"name"];
            }else{
                [self.xmlDic setValue:self.contentStr forKey:@"name"];
            }
        }else if ([elementName isEqualToString:@"subway"]){
            [self.xmlArr addObject:self.xmlDic];
        }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    cell.textLabel.text =@"影院";
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
