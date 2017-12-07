//
//  UPSEquipmentModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/6.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPSEquipmentModel : NSObject

///UPS设备ID
@property (nonatomic,assign)NSUInteger id;
///UPS设备名称
@property (nonatomic,copy)NSString *groupName;
///分组id
@property (nonatomic,assign)NSInteger groupId;




@end
