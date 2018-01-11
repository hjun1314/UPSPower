//
//  UPSSingalAlarmRecordModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/20.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
///获取单个设备告警详细记录模型
@interface UPSSingalAlarmRecordModel : NSObject
///告警编码
@property (nonatomic,copy)NSString *alarmCode;
///告警名称
@property (nonatomic,copy)NSString *alarmDesc;
///发生时间
@property (nonatomic,copy)NSString *happenTime;
///解除时间
@property (nonatomic,copy)NSString *removeTime;



@end
