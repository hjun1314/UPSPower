//
//  UPSAlarmCell.m
//  UPSPower
//
//  Created by hjun on 2017/11/24.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSAlarmCell.h"
#import "UPSAlarmBtn.h"
#import "UPSAlarmModel.h"
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
    
    CGFloat btnW = kScreenW * 0.2;
    CGFloat btnBw = kScreenW *0.4;
    
    
    
    UPSAlarmBtn *nameBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(0, 0,btnW, self.height)];
    [self.contentView addSubview:nameBtn];
    self.nameBtn = nameBtn;
    //    [nameBtn setTitle:@"告警信息" forState:UIControlStateNormal];
    [nameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (iphone4 || iphone5) {
        nameBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }else if(iphone6 || iphoneX){
        nameBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }else{
        nameBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    //    nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UPSAlarmBtn *eventBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(btnW, 0,btnBw, self.height)];
    [self.contentView addSubview:eventBtn];
    self.eventBtn = eventBtn;
    [eventBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (iphone4 || iphone5) {
        eventBtn.titleLabel.font = [UIFont systemFontOfSize:10.5];
        
    }else if(iphone6 || iphoneX){
        eventBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }else{
        eventBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    //[eventBtn addTarget:self action:@selector(clickLevelBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UPSAlarmBtn *levelBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(btnW + btnBw, 0, btnW , self.height)];
    [self.contentView addSubview:levelBtn];
    self.levelBtn = levelBtn;
    [levelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (iphone4 || iphone5) {
        levelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }else if(iphone6 || iphoneX){
        levelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }else{
        levelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    
    
    UPSAlarmBtn *activtionBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(btnW * 2 + btnBw, 0, btnW, self.height)];
    [self.contentView addSubview:activtionBtn];
    [activtionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activtionBtn setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    [activtionBtn setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateSelected];
    self.selectBtn = activtionBtn;
    self.selectBtn.selected = self.isSelected;
    //    activtionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UPSAlarmBtn *allBtn = [[UPSAlarmBtn alloc]initWithFrame:CGRectMake(0, 0, kScreenW, self.height)];
    [self.contentView addSubview:allBtn];
    allBtn.tag = 10;
    [allBtn setBackgroundColor:[UIColor clearColor]];
     [allBtn addTarget:self action:@selector(clickAllBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickAllBtn:(UIButton *)btn{
    self.selectBtn.selected = !self.selectBtn.selected;
    if (self.cartBlock) {
        self.cartBlock(self.selectBtn.selected);
    }
}

-(void)reloadDataWith:(UPSAlarmModel *)model {
//    NSLog(@"%@",model.alarmName);
    self.selectBtn.selected = self.isSelected;
    
}


//- (void)clickLevelBtn{
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"didClickLevelBtn" object:nil];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
