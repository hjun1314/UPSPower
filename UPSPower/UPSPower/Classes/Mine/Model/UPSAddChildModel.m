//
//  UPSAddChildModel.m
//  UPSPower
//
//  Created by hjun on 2017/12/8.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSAddChildModel.h"
#define  ChildrenUserId @"ChildrenUserId"
@implementation UPSAddChildModel

///存id
+(void)saveChildrenUserId:(NSInteger)childrenUserId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:childrenUserId forKey:ChildrenUserId];
    [userDefaults synchronize];
}
///取id
+(NSInteger)getChildrenUserId{
    return [[NSUserDefaults standardUserDefaults]integerForKey:ChildrenUserId];
}

@end
