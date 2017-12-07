//
//  UPSEquipmentVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/22.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSEquipmentVC.h"
#import "YUFoldingTableView.h"
#import "UPSEquipmentCell.h"
#import "UPSNormalVC.h"
#import "UPSUnknownVC.h"
#import "UPSFaultVC.h"
@interface UPSEquipmentVC ()<YUFoldingTableViewDelegate>

@property (nonatomic,strong)YUFoldingTableView *tableView;
@property (nonatomic, assign)YUFoldingSectionHeaderArrowPosition arrowPosition;
@property (nonatomic,assign)BOOL isOpen;


@end

@implementation UPSEquipmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
    [self setupNotification];
}
- (void)setupNav{
    self.navigationItem.title = @"设备状态";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加分组" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarItem)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}
- (void)clickRightBarItem{
    
    
}
- (void)setupTableView{
    
    
    YUFoldingTableView *tableView = [[YUFoldingTableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 35, kScreenW, kScreenH - SafeAreaTabbarHeight - SafeAreaTopHeight - 35)];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.foldingDelegate =self;
    if (self.arrowPosition) {
        tableView.foldingState = YUFoldingSectionStateShow;
    }
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenW, 35)];
    headView.backgroundColor = UICOLOR_RGB(245, 245, 245, 1);
    [self.view addSubview:headView];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, headView.width, 25)];
    title.text = @"设备";
    [headView addSubview:title];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTab)];
    [headView addGestureRecognizer:tap];
    
    
   
}

///手势的点击
- (void)clickTab{
//    if (!self.isOpen) {
//        self.tableView.hidden = YES;
//        self.view.backgroundColor = [UIColor redColor];
//    }else{self.tableView.hidden = NO;
//        self.view.backgroundColor = [UIColor whiteColor];
//
//    }
//    NSLog(@"点击了");
//    self.tableView.hidden = YES;
}

#pragma mark- 创建点击通知
- (void)setupNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickUnknownBtn) name:@"clickUnknownBtn" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickFaultBtn) name:@"clickFaultBtn" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickNormalBtn) name:@"clickNormalBtn" object:nil];
}
- (void)clickUnknownBtn{
    UPSUnknownVC *unknown = [[UPSUnknownVC alloc]init];
    [self.navigationController pushViewController:unknown animated:YES];
}
- (void)clickFaultBtn{
    UPSFaultVC *fault = [[UPSFaultVC alloc]init];
    [self.navigationController pushViewController:fault animated:YES];
}
- (void)clickNormalBtn{
    UPSNormalVC *normal = [[UPSNormalVC alloc]init];
    [self.navigationController pushViewController:normal animated:YES];

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark- 代理方法
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return 5;
}

-(YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
    return self.arrowPosition ? :YUFoldingSectionHeaderArrowPositionLeft;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    return 1;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"上证所1楼";
    }else if (section == 1){
        return @"上证所2楼";
    }else if (section == 2){
        return @"上证所3楼";
    }else if (section == 3){
        return @"上证所4楼";
    }else{
        return @"上证所5楼";
        
    }
    
}

- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UPSEquipmentCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UPSEquipmentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}


- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSLog(@"ddddd");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
