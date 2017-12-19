//
//  UPSAlarmCell.h
//  UPSPower
//
//  Created by hjun on 2017/11/24.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UPSAlarmModel;
///声明block
typedef void (^cartBlock)(BOOL select);
@interface UPSAlarmCell : UITableViewCell
@property (nonatomic,strong)UIButton *eventBtn;
@property (nonatomic,strong)UIButton *nameBtn;
@property (nonatomic,strong)UIButton *levelBtn;
///覆盖cell的按钮
@property (nonatomic,strong)UIButton *selectAllBtn;
@property (nonatomic,assign)  BOOL isSelected; //是否被选中
@property (nonatomic,copy)cartBlock cartBlock;

//方法 //需要传的值
- (void)reloadDataWith:(UPSAlarmModel *)model;
@end
