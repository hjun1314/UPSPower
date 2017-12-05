//
//  UPSAlarmCell.m
//  UPSPower
//
//  Created by hjun on 2017/11/24.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSAlarmCell.h"
#import "UPSAlarmBtn.h"
@interface UPSAlarmCell()

@property (nonatomic,strong)UIButton *selectBtn;


@end
@implementation UPSAlarmCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UPSAlarmBtn *nameBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(0, 0,kScreenW /3, 30)];
    [self addSubview:nameBtn];
    [nameBtn setTitle:@"告警信息" forState:UIControlStateNormal];
    [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (iphone4 || iphone5) {
        nameBtn.titleLabel.font = [UIFont systemFontOfSize:13];

    }else if(iphone6){
        nameBtn.titleLabel.font = [UIFont systemFontOfSize:14];

    }else{
        nameBtn.titleLabel.font = [UIFont systemFontOfSize:15];

    }
//    nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UPSAlarmBtn *levelBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(kScreenW /3, 0, kScreenW /3, 30)];
    [self addSubview:levelBtn];
    self.levelBtn = levelBtn;
    [levelBtn setTitle:@"运行信息" forState:UIControlStateNormal];
    [levelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    levelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [levelBtn addTarget:self action:@selector(clickLevelBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UPSAlarmBtn *activtionBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake((kScreenW / 3)* 2, 0, kScreenW / 3, 30)];
    [self addSubview:activtionBtn];
    [activtionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activtionBtn setImage:[UIImage imageNamed:@"xkuang_nor"] forState:UIControlStateNormal];
    [activtionBtn setImage:[UIImage imageNamed:@"xkuang_onclick"] forState:UIControlStateSelected];
    [activtionBtn addTarget:self action:@selector(clickActivtionBtn:) forControlEvents:UIControlEventTouchUpInside];
//    activtionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
}

- (void)clickActivtionBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
}

- (void)clickLevelBtn{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"didClickLevelBtn" object:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
