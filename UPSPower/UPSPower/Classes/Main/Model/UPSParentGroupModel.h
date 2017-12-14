//
//  UPSParentGroupModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/7.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface UPSParentGroupModel : NSObject
//Singleton_h(UPSParentGroupModel);
///分组id
@property (nonatomic,assign)NSInteger groupId;
///分组名称
@property (nonatomic,copy)NSString *groupName;




@end
