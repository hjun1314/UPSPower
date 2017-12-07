//
//  UPSMainModel.m
//  UPSPower
//
//  Created by hjun on 2017/12/6.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSMainModel.h"

@implementation UPSMainModel
Singleton_m(UPSMainModel);

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeInteger:self.userChildrenId forKey:@"userChildrenId"];
    [aCoder encodeInteger:self.companyId forKey:@"companyId"];
    [aCoder encodeObject:self.token forKey:@"token"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self.userId = [aDecoder decodeIntegerForKey:@"userId"];
    self.userChildrenId = [aDecoder decodeIntegerForKey:@"userChildrenId"];
    self.companyId = [aDecoder decodeIntegerForKey:@"companyId"];
    self.token = [aDecoder decodeObjectForKey:@"token"];
    return self;
}


@end
