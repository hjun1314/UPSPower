//
//  UPSEquipmentCell.h
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EquipmentBtnDelegate<NSObject>

- (void)didClickUnknownBtn:(UIButton *)unknownBtn;

- (void)didClickFaultBtn:(UIButton *)faultBtn;


@end
@interface UPSEquipmentCell : UITableViewCell

@property (nonatomic,weak)id <EquipmentBtnDelegate>delegate;



@end
