//
//  UPSPageBaseController.h
//  UPS
//
//  Created by hjun on 2017/9/15.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UPSPageBaseController : UIViewController
//@property (strong, nonatomic) SVProgressHUD *HUD;

@property (strong, nonatomic) UITableView *tableView;

/**
 *  模型数组
 */
@property (strong, nonatomic) NSMutableArray *dataArray;

/**
 *  当前页
 */
@property (assign, nonatomic) int currPage;
/**
 *  总条数
 */
@property (assign, nonatomic) NSInteger totalNumber;


/**
 *  配置父视图UI(tableView)
 */
- (void)configSuperViewFrame:(CGRect)frame;

/**
 *  刷新头视图和尾视图(tableView)
 */
- (void)addMJRefreshHeader:(BOOL)isHaveHeader addFooter:(BOOL)isHaveFooter;



@end
