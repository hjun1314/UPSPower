//
//  UPSAddChildModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/8.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPSAddChildModel : NSObject
///添加子账号模型
@property (nonatomic,copy)NSString *username;

@property (nonatomic,assign)NSInteger childrenUserId;

@property (nonatomic,assign)NSInteger parentId;

@property (nonatomic,assign)NSInteger companyId;


///存id
+(void)saveChildrenUserId:(NSInteger)childrenUserId;
///取id
+(NSInteger)getChildrenUserId;




@end
