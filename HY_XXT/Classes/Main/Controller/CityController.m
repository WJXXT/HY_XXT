//
//  CityController.m
//  HY_XXT
//
//  Created by XXT on 15/10/6.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "CityController.h"
#import "AFNReuest.h"
#import "CityData.h"
@interface CityController ()
@property (nonatomic,strong)NSMutableArray *cityarr;
@property (nonatomic,strong)NSMutableDictionary *citydic;
@property (nonatomic,strong)NSMutableArray *hotcity;
@property (nonatomic,assign)NSInteger current;
@end

@implementation CityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"选择城市";
    [self leftBarButton];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self layoutCity];
     self.tableView.sectionIndexColor = [UIColor blackColor];
}
-(void)layoutCity{
    NSString *str =[NSString stringWithFormat:@"%@/v1/cities.json",kMaoYanURL];
    [AFNReuest JSONDataWithUrl:str success:^(id json) {
         NSArray *arr =[json valueForKey:@"data"];
        self.citydic =[NSMutableDictionary dictionary];
        self.cityarr =[NSMutableArray array];
        self.hotcity =[NSMutableArray array];
        for (NSDictionary *dic in arr) {
            CityData *data =[CityData new];
            [data setValuesForKeysWithDictionary:dic];
            NSString *firstr =[[data.py substringToIndex:1]uppercaseString];
            if (self.hotcity.count <4) {
                [self.hotcity addObject:data];
            }
            int n = 0;
            for (NSString *key in self.citydic) {
                if ([key isEqual:firstr]) {
                    n = 1;
                    NSMutableArray *dataarr =[self.citydic valueForKey:key];
                    [dataarr addObject:data];
                }
            }
            if (n == 0) {
                NSMutableArray *dataarr =[NSMutableArray array];
                [dataarr addObject:data];
                [self.citydic setValue:dataarr forKey:firstr];
            }
        }

        NSArray *allkeys = [self.citydic allKeys];
        NSMutableArray *keys =[NSMutableArray arrayWithArray:[allkeys sortedArrayUsingSelector:@selector(compare:)]];
        [self.cityarr addObject:@"定位"];
        [self.cityarr addObject:@"热门"];
        [self.cityarr addObjectsFromArray:keys];
        NSArray *arrs =[NSArray arrayWithObject:@"暂时无法获取城市"];
        [self.citydic setValue:arrs forKey:@"定位"];
        [self.citydic setValue:self.hotcity forKey:@"热门"];
//        NSLog(@"%@",self.citydic);
                [self.tableView reloadData];
    } fail:^{
        NSLog(@"数据请求错误");
    }];
}

-(void)leftBarButton{
    
    UIImage* backImage = [UIImage imageNamed:@"icon_backorange"];
    
    CGRect backframe = CGRectMake(0,0,30,30);
    
    UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
    
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    
    backButton.titleLabel.font=[UIFont systemFontOfSize:13];
    
    [backButton addTarget:self action:@selector(doClickBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}
-(void)doClickBackAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        NSArray *arr =[self.citydic valueForKey:self.cityarr[section]];
    
        return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSArray *arr =[self.citydic valueForKey:self.cityarr[indexPath.section]];
    if (indexPath.section == 0) {
        cell.textLabel.text =arr[indexPath.row];
    }else{
        CityData *data = arr[indexPath.row];
        cell.textLabel.text =data.nm;
        cell.tintColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath

{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;//cell右边的形状是对号
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
        return [self.cityarr objectAtIndex:section];
}

//返回索引栏数据

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.cityarr;
}

//建立索引栏和section的关联
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return [self.cityarr indexOfObject:title];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
