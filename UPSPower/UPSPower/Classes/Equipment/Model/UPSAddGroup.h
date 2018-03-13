//
//  UPSAddGroup.h
//  UPSPower
//
//  Created by hjun on 2017/12/8.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UPSAddGroup : NSObject
///添加分组模型

@property (nonatomic,assign)NSInteger groupId;

///新分组名称
@property (nonatomic,copy)NSString *groupName;

//@property (nonatomic,strong)NSMutableArray *groupCellData;


@end
