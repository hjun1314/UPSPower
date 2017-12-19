//
//  UPSGroupUPSModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/7.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPSGroupUPSModel : NSObject
///ups设备id
@property (nonatomic,assign)NSInteger id;
///分组id
@property (nonatomic,assign)NSInteger groupId;
///设备名称
@property (nonatomic,copy)NSString *userDefinedUpsName;
///状态
@property (nonatomic,assign)NSInteger statId;
///原始名称
@property (nonatomic,copy)NSString *originalUpsName;






@end
