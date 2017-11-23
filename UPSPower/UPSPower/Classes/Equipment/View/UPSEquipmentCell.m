//
//  UPSEquipmentCell.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSEquipmentCell.h"
@interface UPSEquipmentCell()
@property (nonatomic,strong)UIButton *normal;

@end
@implementation UPSEquipmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    UIButton *unknownBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 100, 20)];
    [self addSubview:unknownBtn];
    [unknownBtn setTitle:@"设备1 未知" forState:UIControlStateNormal];
    [unknownBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [unknownBtn addTarget:self action:@selector(clickUnknownBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *faultBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 100, 20)];
    [faultBtn setTitle:@"设备2 异常" forState:UIControlStateNormal];
    [faultBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:faultBtn];
    [faultBtn addTarget:self action:@selector(didFaultBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *normalBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 50, 100, 20)];
    [normalBtn setTitle:@"设备3 正常" forState:UIControlStateNormal];
    [normalBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self addSubview:normalBtn];
    [normalBtn addTarget:self action:@selector(didnormalBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickUnknownBtn:(UIButton *)unknownBtn{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickUnknownBtn" object:nil];

}

- (void)didFaultBtn:(UIButton *)faultBtn{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickFaultBtn" object:nil];
    
}

- (void)didnormalBtn:(UIButton *)normalBtn{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickNormalBtn" object:nil];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
