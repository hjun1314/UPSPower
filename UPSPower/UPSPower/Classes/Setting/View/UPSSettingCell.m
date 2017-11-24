//
//  UPSSettingCell.m
//  UPSPower
//
//  Created by hjun on 2017/11/23.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSSettingCell.h"

@implementation UPSSettingCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UILabel *unknownLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.width - 20, 20)];
    [self addSubview:unknownLabel];
    unknownLabel.text = @"上海UPSx1 异常1次";
//    unknownLabel.textColor = [UIColor lightGrayColor];
    
    UILabel *faultLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 25, self.width - 20, 20)];
    faultLabel.text = @"上海UPSx1 异常2次";
    [self addSubview:faultLabel];
    
    
    UILabel *normalLbael = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, self.width - 20, 20)];
    normalLbael.text = @"正常";
//    normalLbael.textColor = [UIColor lightGrayColor];
    [self addSubview:normalLbael];
    
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
