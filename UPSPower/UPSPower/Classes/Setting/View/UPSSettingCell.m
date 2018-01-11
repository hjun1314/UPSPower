//
//  UPSSettingCell.m
//  UPSPower
//
//  Created by hjun on 2017/12/19.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSSettingCell.h"
#import "SDAutoLayout.h"
#import "UPSAlarmRecordModel.h"
@interface UPSSettingCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end
@implementation UPSSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.point.sd_layout.topSpaceToView(self.contentView, 20).leftSpaceToView(self.contentView, 5).widthIs(8).heightEqualToWidth();
    
    self.point.sd_cornerRadius = @(4);
    
    self.topLine.sd_layout.topEqualToView(self.contentView).leftSpaceToView(self.contentView,8.5).widthIs(1).bottomSpaceToView(self.point, 0);
    
    self.bottomLine.sd_layout.topSpaceToView(self.point,0).leftSpaceToView(self.contentView,8.5).widthIs(1).bottomSpaceToView(self.contentView, 0);
    
    
//    self.iconView.sd_layout.topSpaceToView(self.contentView , 10).leftSpaceToView(self.point, 3).bottomSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10);
//       self.iconView.image = [UIImage imageNamed:@"WechatIMG3"];
    
    // 指定为拉伸模式，伸缩后重新赋值
    
//    self.iconView.image = [self.iconView.image stretchableImageWithLeftCapWidth:20 topCapHeight:30];
    
    self.timeLabel.sd_layout.centerYEqualToView(self.point).leftSpaceToView(self.contentView, 35).rightSpaceToView(self.contentView, 15).heightIs(20);
    
    self.contentLabel.sd_layout.topSpaceToView(self.timeLabel, 15).leftEqualToView(self.timeLabel).rightSpaceToView(self.contentView, 15).autoHeightRatio(0);
    
}

- (void)setModel:(UPSAlarmRecordModel *)model{
    _model = model;
    self.contentLabel.text = model.userDefinedUpsName;
    self.timeLabel.text = model.happenTime;
   
      [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:15];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
