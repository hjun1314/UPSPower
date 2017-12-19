//
//  UPSMainModel.h
//  UPSPower
//
//  Created by hjun on 2017/12/6.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UPSParentGroupModel;
@interface UPSMainModel : NSObject<NSCoding>

Singleton_h(UPSMainModel);

///分栏数据
@property (nonatomic,strong)NSMutableArray *parentGroup;
///UPS数据
@property (nonatomic,strong)NSMutableArray *groupUps;
///用户id
@property (nonatomic,assign)NSInteger userId;
///子用户id
@property (nonatomic,assign)NSInteger userChildrenId;
///公司id
@property (nonatomic,assign)NSInteger companyId;
///登录token
@property (nonatomic,copy)NSString *token;
///是否子账号
@property (nonatomic,assign)BOOL userChildren;

@end
