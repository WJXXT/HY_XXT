//
//  ShowmoiveTableViewController.m
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "ShowmoiveTableViewController.h"
#import "AFNReuest.h"
#import "MoviesData.h"
#import "ReqShowMoiveData.h"
#import "ShowMovieCell.h"
#import "ShowMoiveData.h"
#import "UIImageView+WebCache.h"
@interface ShowmoiveTableViewController ()

@property (nonatomic,strong)NSMutableArray *moviesarr;

@end

@implementation ShowmoiveTableViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowMovieCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"movieIdentifier"];
    [self reqData];
}

-(void)reqData{
    ReqShowMoiveData *movieReq =[[ReqShowMoiveData alloc]init:@"购票-热映"];
    self.moviesarr =[NSMutableArray arrayWithArray:movieReq.allArr];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.moviesarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieIdentifier" forIndexPath:indexPath];
    ShowMoiveData *data =self.moviesarr[indexPath.row];
    
    CGFloat x=cell.moviename.frame.origin.x;
    CGFloat y=cell.moviename.frame.origin.y;
    CGSize labelsize = [data.moviename sizeWithAttributes:@{NSFontAttributeName:cell.moviename.font}];
    CGFloat wightafter = 140;
    if (labelsize.width < 140) {
        [cell.moviename setFrame:CGRectMake(x,y, labelsize.width, labelsize.height)];
        wightafter =labelsize.width;
    }
    cell.moviename.text =data.moviename;

    [cell.imageLogo sd_setImageWithURL:[NSURL URLWithString:data.logo]];
    if (![data.highlight isEqualToString:@""]) {
        cell.moviemeg.text =data.highlight;
    }else{
        NSString *director =[NSString stringWithFormat:@"导演:%@\n演员:%@",data.director,data.actors];
        cell.moviemeg.text =director;
    }
    cell.backgroundColor =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    NSDictionary *dic =data.icon[0];
    CGFloat wight =[[dic valueForKey:@"imgWight"] floatValue];
    CGFloat height =[[dic valueForKey:@"imgHeight"] floatValue];
    cell.icon.frame =CGRectMake(x +wightafter+10,y+3,wight/2,height/2);
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"imgIcon"]]];
    cell.countdes.text =data.countdes;
    cell.generalmark.text =data.generalmark;
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
