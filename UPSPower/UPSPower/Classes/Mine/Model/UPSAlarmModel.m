//
//  UPSAlarmModel.m
//  UPSPower
//
//  Created by hjun on 2017/12/13.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSAlarmModel.h"

@implementation UPSAlarmModel
Singleton_m(UPSAlarmModel);
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.typeId forKey:@"typeId"];
   
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self.typeId = [aDecoder decodeIntegerForKey:@"typeId"];
    
    return self;
}

@end
