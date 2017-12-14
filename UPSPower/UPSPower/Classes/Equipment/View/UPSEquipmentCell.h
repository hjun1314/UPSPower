//
//  UPSEquipmentCell.h
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UPSGroupUPSModel;

@interface UPSEquipmentCell : UITableViewCell

@property (nonatomic,strong)UPSGroupUPSModel *upsModel;

@property (nonatomic,strong)UIButton *normal;


@end
