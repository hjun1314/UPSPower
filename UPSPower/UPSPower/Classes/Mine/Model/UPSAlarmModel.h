//
//  UPSAlarmModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/13.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPSAlarmModel : NSObject<NSCoding>

Singleton_h(UPSAlarmModel);
///此配置id
@property (nonatomic,assign)NSInteger upsSettingId;
///报警编号
@property (nonatomic,copy)NSString *alarmCode;
///告警名称
@property (nonatomic,copy)NSString *alarmName;
///告警类型Id
@property (nonatomic,assign)NSInteger typeId;
///用户id
@property (nonatomic,assign)NSInteger typeName;
///是否停用
@property (nonatomic,assign)BOOL isUse;







@end
