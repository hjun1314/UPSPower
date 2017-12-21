//
//  UPSAlarmRecordModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/20.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
///获取报警记录模型
@interface UPSAlarmRecordModel : NSObject
///ups主键
@property (nonatomic,assign)long upsId;
///告警总数
@property (nonatomic,assign)NSInteger amount;
///ups名称
@property (nonatomic,copy)NSString *upsName;
///发生时间
@property (nonatomic,strong)NSDate *happenTime;




@end
