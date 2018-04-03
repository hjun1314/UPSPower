//
//  UPSSettingCell.h
//  UPSPower
//
//  Created by hjun on 2017/12/19.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UPSAlarmRecordModel;
@interface UPSSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *point;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (nonatomic,strong)UPSAlarmRecordModel *model;


@end
