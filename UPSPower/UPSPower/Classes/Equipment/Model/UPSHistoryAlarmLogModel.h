//
//  UPSHistoryAlarmLogModel.h
//  UPSPower
//
//  Created by hjun on 2018/3/6.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPSHistoryAlarmLogModel : NSObject

///告警编码
@property (nonatomic,copy)NSString *alarmCode;
///告警名称
@property (nonatomic,copy)NSString *alarmDesc;
///发生时间
@property (nonatomic,copy)NSString *happenTime;
///解除时间
@property (nonatomic,copy)NSString *removeTime;


@end
