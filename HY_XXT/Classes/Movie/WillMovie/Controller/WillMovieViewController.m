//
//  WillMovieViewController.m
//  HY_XXT
//
//  Created by XXT on 15/10/7.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "WillMovieViewController.h"
#import "ReqWillMovieData.h"
#import "WillMovieData.h"
#import "ShowMovieCell.h"
#import "UIImageView+WebCache.h"
@interface WillMovieViewController ()
@property (nonatomic,strong)NSMutableArray *moviesarr;
@end

@implementation WillMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowMovieCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"movieIdentifier"];
    [self reqData];
}
-(void)reqData{
    ReqWillMovieData *movieReq =[[ReqWillMovieData alloc]init:@"购票-即将上映"];
    self.moviesarr =[NSMutableArray arrayWithArray:movieReq.allArr];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.moviesarr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *movie = self.moviesarr[section];
    return movie.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieIdentifier" forIndexPath:indexPath];
    NSArray *movie =self.moviesarr[indexPath.section];
    WillMovieData *data =movie[indexPath.row];
    
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
    cell.countdes.text =data.releasedateDescForList;
    NSString *str =[NSString stringWithFormat:@"%@人想看",data.xiangkan];
    cell.generalmark.font =[UIFont fontWithName:@"Helvetica-Bold" size:18];
    CGSize xiangkansize = [str sizeWithAttributes:@{NSFontAttributeName:cell.generalmark.font}];
    cell.generalmark.frame =CGRectMake(kScreenWidth-xiangkansize.width, 20, xiangkansize.width, xiangkansize.height);
    cell.generalmark.text =str;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}
//设置分区 title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"最受关注";
    }
    return @"即将上映";
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
