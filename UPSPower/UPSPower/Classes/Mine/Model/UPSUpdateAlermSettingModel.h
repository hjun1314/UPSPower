//
//  UPSUpdateAlermSettingModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/13.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
///更新告警设置模型

@interface UPSUpdateAlermSettingModel : NSObject
///此配置id
@property (nonatomic,assign)NSInteger upsSettingId;
///是否启用
@property (nonatomic,assign)BOOL isUse;
///告警名称
@property (nonatomic,copy)NSString *alarmName;
///用户id
@property (nonatomic,assign)NSInteger typeName;


@end
