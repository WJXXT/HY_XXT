//
//  ActitivyCell.h
//  HY_XXT
//
//  Created by XXT on 15/10/10.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActitivyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *clickedtimesLb;
@property (weak, nonatomic) IBOutlet UILabel *endtimeLb;


@end
