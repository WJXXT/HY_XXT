//
//  CinemaCell.m
//  HY_XXT
//
//  Created by XXT on 15/10/9.
//  Copyright (c) 2015年 XXT. All rights reserved.
//

#import "CinemaCell.h"
#import "TitleLabel.h"
#import "ChartImageView.h"
#import "UIImageView+WebCache.h"
@interface CinemaCell ()
@property(nonatomic,strong)TitleLabel *cinemanameLb;
@property(nonatomic,strong)TitleLabel *addressLb;
@property(nonatomic,strong)TitleLabel *countdesLb;
@property(nonatomic,strong)UIImageView *myCinemaimg;
@property(nonatomic,strong)UIImageView *iconone;
@property(nonatomic,strong)UIImageView *icontwo;
@property(nonatomic,strong)UILabel *generalmarkLb;
@property(nonatomic,strong)ChartImageView *characteristicIconView;
@end
@implementation CinemaCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.myCinemaimg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.iconone =[[UIImageView alloc]init];
        self.icontwo =[[UIImageView alloc]init];
        self.generalmarkLb =[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-30, 10, 30, 30)];
        self.generalmarkLb.font =[UIFont fontWithName:@"Helvetica-Bold" size:12];
        self.generalmarkLb.textColor =[UIColor orangeColor];
        [self.contentView addSubview:self.myCinemaimg];
        self.cinemanameLb = [[TitleLabel alloc]init];

        self.addressLb = [[TitleLabel alloc]init];

        self.countdesLb = [[TitleLabel alloc]init];
        
        self.characteristicIconView =[[ChartImageView alloc]init];
        [self.contentView addSubview:self.characteristicIconView];
        [self.contentView addSubview:self.cinemanameLb];
        [self.contentView addSubview:self.addressLb];
        [self.contentView addSubview:self.countdesLb];
        [self.contentView addSubview:self.generalmarkLb];
        [self.contentView addSubview:self.iconone];
        [self.contentView addSubview:self.icontwo];
    }
    return self;
}
//
-(void)setCinemadata:(CinemaData *)cinemadata{
    if (_cinemadata!= cinemadata)
    {
        _cinemadata =[CinemaData new];
        _cinemadata =cinemadata;
        if([self.cinemadata.myCinema isEqualToString:@"1"]){
            self.myCinemaimg.image =[UIImage imageNamed:@"icon_been"];
        }
        
        [self.cinemanameLb layoutLabelFrame:20 Title:self.cinemadata.cinemaname Font:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [self.addressLb layoutLabelFrame:50 Title:self.cinemadata.address Font:[UIFont fontWithName:@"Helvetica" size:15]];
        [self.countdesLb layoutLabelFrame:90 Title:self.cinemadata.countdes Font:[UIFont fontWithName:@"Helvetica-Oblique" size:11]];
        if (self.cinemadata.icon.count) {
            DesceiphionData *one = self.cinemadata.icon[0];
            DesceiphionData *two = self.cinemadata.icon[1];
            self.iconone.frame =CGRectMake(self.cinemanameLb.frame.size.width+10+5, 23, [one.imgWight floatValue]/2, [one.imgHeight floatValue]/2);
            self.icontwo.frame =CGRectMake(self.cinemanameLb.frame.size.width+10+5+[one.imgWight floatValue]/2+5, 23, [two.imgWight floatValue]/2, [two.imgHeight floatValue]/2);
            [self.iconone sd_setImageWithURL:[NSURL URLWithString:one.imgIcon]];
            [self.icontwo sd_setImageWithURL:[NSURL URLWithString:two.imgIcon]];
        }
        
        
        self.generalmarkLb.text =self.cinemadata.generalmark;
        
        CGFloat iconX=self.countdesLb.frame.size.width +10+5;
        self.characteristicIconView.frame =CGRectMake(iconX, 90, kScreenWidth-30-iconX, 30);
        [self.characteristicIconView addImageView:self.cinemadata.characteristicIcon];


    }
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
