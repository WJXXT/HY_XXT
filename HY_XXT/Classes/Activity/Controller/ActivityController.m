//
//  ActivityController.m
//  HY_XXT
//
//  Created by XXT on 15/10/10.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "ActivityController.h"
#import "RequstMain.h"
#import "ActitivyCell.h"
//#import "tableViewHeaderView.h"
#import "ActivityQueryComCell.h"
#import "UIImageView+WebCache.h"
#import "ActivityMain.h"
#import "RequstComment.h"
#import "ActivityComment.h"
#import "UIImageView+WebCache.h"
@interface ActivityController ()
@property (nonatomic,strong)NSMutableArray *actitivyArr;
@property (nonatomic,strong)NSMutableArray *actitivyData;
@property (nonatomic,strong) UIImageView *topView;
@end

@implementation ActivityController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.view.alpha =0;
    self.navigationController.navigationBar.translucent = NO;
    [self.view.layer removeAllAnimations];
    [UIView animateWithDuration:0.1 animations:^{
        self.navigationController.view.transform =CGAffineTransformMakeTranslation(self.view.bounds.size.width/2, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.navigationController.view.transform =CGAffineTransformMakeTranslation(0, 0);
            self.navigationController.view.alpha =1;
        }];
        //还原到原来的状态
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActitivyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"activityIdentifier"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityQueryComCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"activityQueryComIdentifier"];
        self.tableView.contentInset = UIEdgeInsetsMake(550 * 0.5, 0, 0, 0);
    [self reqData];
    [self downImageView];
    self.navigationItem.title =@"活动-北京";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}
-(void)reqData{
    RequstMain *activityMainReq =[[RequstMain alloc]init:@"活动-首页"];
    self.actitivyArr =[NSMutableArray arrayWithArray:activityMainReq.allArr];
    RequstComment *activityList =[[RequstComment alloc]init:@"活动列表1"];
    self.actitivyData =[NSMutableArray arrayWithArray:activityList.allArr];
    [self.tableView reloadData];
}
-(void)downImageView{
    ActivityMain *data =self.actitivyArr[0][0];

    UIImageView *topView = [[UIImageView alloc] init];
    [topView sd_setImageWithURL:[NSURL URLWithString:data.logo]];
    topView.frame = CGRectMake(0, -350, kScreenWidth, 350);
    topView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = self.topView.frame;
    // 向下拽了多少距离
    CGFloat down = -(550 * 0.5) - scrollView.contentOffset.y;
    if (down < 0) {
        frame.origin.y =-350 -down *0.5;
    };
    if (down >0) {
        frame.size.height = 350 + down *2;
        frame.origin.y =-350 -down *1;
    }
//    if (down>=265&&down<=275) {
//        self.navigationController.navigationBar.alpha
//    }
//    NSLog(@"%f",down);
    self.topView.frame = frame;
//    NSLog(@"%f",self.topView.frame .origin.y);
    // 5决定图片变大的速度,值越大,速度越快
//    [[UINavigationBar appearance] setTintColor:[UIColor colorWithWhite:0.0 alpha:0.0]];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
//    NSArray *arr =self.actitivyArr[section];
//    if (section == 1||section==0) {
//        return 1;
//    }
    return self.actitivyData.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ActivityQueryComCell *comcell = [tableView dequeueReusableCellWithIdentifier:@"activityQueryComIdentifier" forIndexPath:indexPath];
            comcell.selectionStyle = UITableViewCellSelectionStyleNone;
            comcell.contentView.backgroundColor =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
        return comcell;
    }
    ActitivyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activityIdentifier" forIndexPath:indexPath];
    ActivityComment *data =self.actitivyData[indexPath.row-1];
    cell.nameLabel.text =data.title;
    [cell.logoImg sd_setImageWithURL:[NSURL URLWithString:data.logo]];
    cell.endtimeLb.text =data.enddate;
    cell.timeLb.text =data.clickedtimes;
    cell.clickedtimesLb.text =[NSString stringWithFormat:@"%@ %@",data.startdate,data.starttime];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor =[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 200;
    }
    return 140;
}
////设置分区
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (section ==1) {
//    tableViewHeaderView *view =[[tableViewHeaderView alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 200-40)];
//    [view layoutHeaderView];
//    return view;
//    }
//    return nil;
//}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//    if (section ==1) {
//        return 200;
//    }
//    return 0;
//}
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
