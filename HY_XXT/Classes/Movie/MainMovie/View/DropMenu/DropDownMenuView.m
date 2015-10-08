//
//  DropDownMenuView.m
//  
//
//  Created by 王新国 on 15/10/8.
//
//

#import "DropDownMenuView.h"
#import "DropData.h"
#import "DropButton.h"
@interface DropDownMenuView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,weak)DropButton *selectedBtn;
@end
@implementation DropDownMenuView
-(id)initWithHeight:(CGFloat)height AllFileKey:(NSArray *)allFilekey{
    DropData *dropdata =[[DropData alloc]init:allFilekey];
    CGFloat heights =200;
    if (!allFilekey) {
        heights =40;
    }else{
        heights =200;
    }
    self = [super initWithFrame:CGRectMake(0, height-200, kScreenWidth, heights)];
    if (self) {

        self.backgroundColor =[UIColor whiteColor];

        self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, heights)];
//        if (!allFilekey) {
//            self.tableview.frame =CGRectMake(0, 0, kScreenWidth, 40);
//            self.frame = CGRectMake(0, 0, kScreenWidth, 40);
//        }
        self.tableview.separatorStyle = UITableViewCellSelectionStyleNone;
        self.tableview.delegate =self;
        self.tableview.dataSource =self;
        for (int i = 0; i<allFilekey.count; i++) {
            self.tableview.frame =CGRectMake(kScreenWidth/3, 0, kScreenWidth/3*2 , 200);
            
            NSIndexPath *first = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableview selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionTop];

            DropButton *bt =[[DropButton alloc]initWithFrame:CGRectMake(0, (32+1)*i, kScreenWidth/3, 32) Title:allFilekey[i]];
            [bt addTarget:self action:@selector(actiondrop:) forControlEvents:UIControlEventTouchUpInside];

            bt.arrdata =[NSArray arrayWithArray:[dropdata.allDic valueForKey:allFilekey[i]]];
            [self addSubview:bt];
            if (i == 0) {
                self.selectedBtn =bt;
                self.selectedBtn.selected =YES;
            }
        }
        [self addSubview:self.tableview];
    }
    return self;
}


-(void)actiondrop:(DropButton *)bt{
    //1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    self.selectedBtn =bt;
    //2.再将当前按钮设置为选中
    self.selectedBtn.selected = YES;
    [self.tableview reloadData];
    NSIndexPath *first = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableview selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionTop];
    

    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.selectedBtn.arrdata.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    //取消选中颜色
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.textLabel.highlightedTextColor = [UIColor orangeColor];
    cell.textLabel.font =[UIFont boldSystemFontOfSize:15];
    cell.textLabel.textAlignment = 1;
    if (indexPath.row == 0&&self.selectedBtn.arrdata.count!=0) {
        cell.textLabel.text =@"全部";
    }else if(indexPath.row == 0&&self.selectedBtn.arrdata.count==0){
        cell.textLabel.text =@"暂无";
    }
    else{
        cell.textLabel.text =[self.selectedBtn.arrdata[indexPath.row-1] valueForKey:@"name"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
//    NSLog(@"%@", cell.textLabel.text);
    //添加 字典，将cell.textLabel.text的值通过key值设置传递
    NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:cell.textLabel.text,@"CinemaStyle", nil];
    //创建通知
    NSNotification *notification =[NSNotification notificationWithName:@"Cinemanot" object:nil userInfo:dict];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];

}
@end
