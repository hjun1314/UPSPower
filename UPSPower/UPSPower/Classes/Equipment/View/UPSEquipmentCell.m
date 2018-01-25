//
//  UPSEquipmentCell.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSEquipmentCell.h"
#import "UPSGroupUPSModel.h"
@interface UPSEquipmentCell()

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
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, (kScreenW - 10) / 3, self.height)];
    [self.contentView addSubview:nameLabel];
    
//    nameLabel.backgroundColor = [UIColor orangeColor];
    self.nameLabel = nameLabel;
   
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenW - 10) / 3 + 10, 0, 50, self.height)];
    [self.contentView addSubview:iconView];
//    iconView.backgroundColor = [UIColor blueColor];
    self.iconView = iconView;

    UILabel *originalLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenW - 10) / 3 * 2, 0, (kScreenW - 10) / 3, self.height)];
    [self.contentView addSubview:originalLabel];
//    originalLabel.backgroundColor = [UIColor redColor];
    self.originalLabel = originalLabel;
    originalLabel.textAlignment = NSTextAlignmentRight;
}

- (void)clickUnknownBtn:(UIButton *)unknownBtn{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickUnknownBtn" object:nil];

}

//- (void)didFaultBtn:(UIButton *)faultBtn{
//
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickFaultBtn" object:nil];
//    
//}
//
//- (void)didnormalBtn:(UIButton *)normalBtn{
//    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickNormalBtn" object:nil];
//    
//}

- (void)setUpsModel:(UPSGroupUPSModel *)upsModel{
    _upsModel = upsModel;
   // [self.normal setTitle:upsModel.upsName forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
