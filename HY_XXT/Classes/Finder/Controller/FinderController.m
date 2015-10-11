//
//  FinderController.m
//  HY_XXT
//
//  Created by XXT on 15/10/10.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "FinderController.h"
#import "AFNReuest.h"
#import "CityController.h"
#import "RequestAdvert.h"
#import "AdvertisingData.h"
#import "TurnView.h"
@interface FinderController ()
@property (nonatomic,assign)NSInteger citySelet;
@property (nonatomic,strong)NSMutableArray *advertisingArr;
@property (nonatomic,strong)TurnView *topView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger turnImageCount;
@end

@implementation FinderController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.timer setFireDate:[NSDate distantFuture]];
        self.tableView.alpha =0;
        [self.tableView.layer removeAllAnimations];
        [UIView animateWithDuration:0.1 animations:^{
//            self.tableView.transform =CGAffineTransformMakeTranslation(self.view.bounds.size.width/2, 0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
//                self.tableView.transform =CGAffineTransformMakeTranslation(self.view.bounds.size.width/2, 0);
                self.tableView.alpha =1;
            }];
            
        }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _citySelet = 1;
    [self resquestData];
    [self turnImageView];


}



-(void)resquestData{
    RequestAdvert *activityMainReq =[[RequestAdvert alloc]init:@"发现-活动"];
    self.advertisingArr =[NSMutableArray arrayWithArray:activityMainReq.allArr][0];
    
}
-(void)turnImageView{
    self.tableView.contentInset = UIEdgeInsetsMake(550 * 0.5, 0, 0, 0);
    TurnView *topView =[[TurnView alloc]initWithFrame:CGRectMake(0, -350, kScreenWidth, 350) Data:self.advertisingArr];

//    topView.frame = CGRectMake(0, -350, kScreenWidth, 350);
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;
    [self.tableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (_citySelet == 1) {
        CityController *cityer =[[CityController alloc]init];
        UINavigationController *naVc= [[UINavigationController alloc]initWithRootViewController:cityer];
        [self presentViewController:naVc animated:YES completion:nil];
        _citySelet =0;
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self.timer setFireDate:[NSDate distantPast]];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIImageView *selectView =(UIImageView *)[self.topView viewWithTag:200+self.turnImageCount];
    CGRect frame = selectView.frame;
     CGRect turnframe = self.topView.frame;
//    NSLog(@"%f",selectView.frame.origin.y);
    // 向下拽了多少距离
    CGFloat down = -(550 * 0.5) - scrollView.contentOffset.y;
//        NSLog(@"%f",down);
    if (down < 0) {
        frame.origin.y =-down *0.5;
    };
    if (down >0) {
        frame.size.height = 350 + down *2;
        frame.origin.y = -down *1;
        
        turnframe.origin.y =-350 -down *1;
        turnframe.size.height = 350 + down *2;
    }
    selectView.frame = frame;
    self.topView.frame =turnframe;
}
// scrollView 开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
//    [self.timer setFireDate:[NSDate distantPast]];
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    [self.timer setFireDate:[NSDate distantFuture]];
    self.topView.contentOffset =CGPointMake(kScreenWidth/2+10, 0);
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
    cell.textLabel.text =@"sda";
    // Configure the cell...
    
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
