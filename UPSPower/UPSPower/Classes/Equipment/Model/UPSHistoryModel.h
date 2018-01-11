//
//  UPSHistoryModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
///查看UPS历史数据模型
@interface UPSHistoryModel : NSObject
/*
 upsId    ups主键    Long    考虑到后期推送，需要此id辨识UPS
 stateId    状态主键    Long    根据此id辨识UPS状态
 stateName    状态名称    String    备用：未来主键发生变动，使用此名称辨别
 modelId    UPS型号    Long
 upsBypassVoltage1    旁路输入电压1    Double    单位：“V”,可null
 upsBypassVoltage2    旁路输入电压2    Double    单位：“V”,可null
 upsBypassVoltage3    旁路输入电压3    Double    单位：“V”,可null
 upsBypassFrequency    旁路输入频率    Double    单位：“Hz”,可null
 upsInputVoltage1    交流输入电压1    Double    单位：“V”,可null
 upsInputVoltage2    交流输入电压2    Double    单位：“V”,可null
 upsInputVoltage3    交流输入电压3    Double    单位：“V”,可null
 upsInputFrequency    交流输入频率    Double    单位：“Hz”,可null
 upsOutputVoltage1    交流输出电压1    Double    单位：“V”,可null
 upsOutputVoltage2    交流输出电压2    Double    单位：“V”,可null
 upsOutputVoltage3    交流输出电压3    Double    单位：“V”,可null
 upsOutputCurrent1     交流输出电流1    Double    单位：“A”,可null
 
 0.0A为交流输出
 upsOutputCurrent2    交流输出电流2    Double    单位：“A”,可null
 upsOutputCurrent3    交流输出电流3    Double    单位：“A”,可null
 upsOutputPercentLoad1     交流输出负载比1    Double    单位：“%”,可null
 
 (0%)为输出百分比
 upsOutputPercentLoad2    交流输出负载比2    Double    单位：“%”,可null
 upsOutputPercentLoad3    交流输出负载比3    Double    单位：“%”,可null
 upsOutputPower    交流输出有效功率    Double    单位：“kW”,可null
 upsOutputFrequency    交流输出频率    Double    单位：“Hz”,可null
 upsBatteryVoltage    电池电压    Double    单位：“V”，可null
 upsBatteryCurrent    电池电流    Double    单位：“A”，可null
 upsInputLineBads    放电次数    Integer    此参数存疑,可null
 upsSecondsOnBattery    放电时间    Double    单位：秒，可null
 upsEstimatedChargeRemaining    剩余电量    Double    单位：“%”可null
 upsBatteryTemperature    电池温度    Integer    单位：“℃”可null
 saveTime    数据发生时间    date    yyyy-MM-dd HH:mm:ss

 
 */

@property (nonatomic,assign)long upsId;
@property (nonatomic,assign)long stateId;
@property (nonatomic,copy)NSString *stateName;
@property (nonatomic,assign)long modelId;
@property (nonatomic,assign)double upsBypassVoltage1;
@property (nonatomic,assign)double upsBypassVoltage2;
@property (nonatomic,assign)double upsBypassVoltage3;
@property (nonatomic,assign)double upsBypassFrequency;
@property (nonatomic,assign)double upsInputVoltage1;
@property (nonatomic,assign)double upsInputVoltage2;
@property (nonatomic,assign)double upsInputVoltage3;
@property (nonatomic,assign)double upsInputFrequency;
@property (nonatomic,assign)double upsOutputVoltage1;
@property (nonatomic,assign)double upsOutputVoltage2;
@property (nonatomic,assign)double upsOutputVoltage3;
@property (nonatomic,assign)double upsOutputCurrent1;
@property (nonatomic,assign)double upsOutputCurrent2;
@property (nonatomic,assign)double upsOutputCurrent3;
@property (nonatomic,assign)double upsOutputPercentLoad1;
@property (nonatomic,assign)double upsOutputPercentLoad2;
@property (nonatomic,assign)double upsOutputPercentLoad3;
@property (nonatomic,assign)double upsOutputPower;
@property (nonatomic,assign)double upsOutputFrequency;
@property (nonatomic,assign)double upsBatteryVoltage;
@property (nonatomic,assign)double upsBatteryCurrent;
@property (nonatomic,assign)NSInteger upsInputLineBads;
@property (nonatomic,assign)double upsSecondsOnBattery;
@property (nonatomic,assign)double upsEstimatedChargeRemaining;
@property (nonatomic,assign)NSInteger upsBatteryTemperature;
@property (nonatomic,strong)NSDate *saveTime;






@end
