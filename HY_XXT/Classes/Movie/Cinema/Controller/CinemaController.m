//
//  CinemaController.m
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "CinemaController.h"
#import "CinemaCell.h"
#import "RequsetCinema.h"
@interface CinemaController ()
@property (nonatomic,strong)NSMutableArray *cinemasArr;
@end

@implementation CinemaController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"Cinemanot" object:nil];
    [self reqData];
}
//接收通知
- (void)tongzhi:(NSNotification *)text{

    NSLog(@"%@",text.userInfo[@"CinemaStyle"]);
}

-(void)reqData{
    RequsetCinema *cinemaReq =[[RequsetCinema alloc]init:@"购票-影院"];
    self.cinemasArr =[NSMutableArray arrayWithArray:cinemaReq.allArr];
    [self.tableView reloadData];
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

    return self.cinemasArr.count;
}

- (CinemaCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identfier = @"影院";
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (cell == nil)
    {
        cell = [[CinemaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
    }
//    NSLog(@"%@",self.cinemasArr[indexPath.row]);
    cell.backgroundColor =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    cell.cinemadata =self.cinemasArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
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
