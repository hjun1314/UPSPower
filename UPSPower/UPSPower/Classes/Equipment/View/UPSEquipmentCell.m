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
    
    
    UIButton *faultBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 100, 20)];
    [faultBtn setTitle:@"设备2 异常" forState:UIControlStateNormal];
    [faultBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:faultBtn];
    [faultBtn addTarget:self action:@selector(didFaultBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickUnknownBtn:(UIButton *)unknownBtn{
    if ([self.delegate respondsToSelector:@selector(didClickUnknownBtn:)]) {
        
        [self.delegate didClickUnknownBtn:unknownBtn];
    }
    NSLog(@"dassda");

}

- (void)didFaultBtn:(UIButton *)faultBtn{
    if ([self.delegate respondsToSelector:@selector(didClickFaultBtn:)]) {
        [self.delegate didClickFaultBtn:faultBtn];
    }
    NSLog(@"dadsaaaaaaaaaaaaa");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
