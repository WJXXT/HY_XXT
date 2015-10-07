//
//  DropDownMenuView.m
//  
//
//  Created by 王新国 on 15/10/8.
//
//

#import "DropDownMenuView.h"
#import "DropButton.h"
@interface DropDownMenuView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,weak)DropButton *selectedBtn;
@end
@implementation DropDownMenuView
-(id)initWithHeight:(CGFloat)height DataDic:(NSDictionary *)dataDic AllKey:(NSArray *)allkey{
    self = [super initWithFrame:CGRectMake(0, height, kScreenWidth, 200)];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        self.tableview.dataSource =self;
        self.tableview.dataSource =self;
        for (int i = 0; i<allkey.count; i++) {
            self.tableview.frame =CGRectMake(100, 0, kScreenWidth -60 , 200);
            DropButton *bt =[[DropButton alloc]initWithFrame:CGRectMake(0, 32*i, 100, 32) Title:allkey[i]];
            [bt addTarget:self action:@selector(actiondrop:) forControlEvents:UIControlEventTouchUpInside];

            bt.arrdata =[NSArray arrayWithArray:[dataDic valueForKey:allkey[i]]];
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
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.selectedBtn.arrdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSDictionary *dic =self.selectedBtn.arrdata[indexPath.row];
    cell.textLabel.text =[dic valueForKey:@"name"];
    
    return cell;
}
@end
