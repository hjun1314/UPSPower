//
//  UPSAlarmVC.m
//  UPSPower
//
//  Created by hjun on 2017/11/24.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSAlarmVC.h"
#import "UPSAlarmCell.h"
#import "UPSAlarmBtn.h"
@interface UPSAlarmVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIView *titleView;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *data;

@end

@implementation UPSAlarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setupTitleView];
    [self setupTableView];
    [self setNontification];
}
- (void)setNav{
    
    self.navigationItem.title = @"告警定义设置";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBack)];
    
}
- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupTitleView{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, self.view.width, 35)];
    titleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.titleView = titleView;
    [self.view addSubview:titleView];
    [self setupTitleButtons];

}

- (void)setupTitleButtons{
    NSArray *titles = @[@"事件名称",@"告警级别",@"激活告警"];
    NSUInteger count = titles.count;
    
    CGFloat titleBtnW = self.titleView.width / count;
    CGFloat titleBtnH = self.titleView.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleBtn = [[UIButton alloc]init];
        [self.titleView addSubview:titleBtn];
        titleBtn.frame = CGRectMake(i * titleBtnW, 0, titleBtnW, titleBtnH);
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    
}

- (void)setupTableView{
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 35 + SafeAreaTopHeight, self.view.width, self.view.height - 35 - SafeAreaTopHeight)];
    tabelView.delegate = self;
    tabelView.dataSource = self;
    tabelView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView = tabelView;
    [self.view addSubview:tabelView];
    
//    UPSAlarmBtn *sureBtn = [[UPSAlarmBtn alloc]init];
//    if (iphone4 || iphone5) {
//        sureBtn.frame = CGRectMake((self.view.width - 160) / 3, self.view.height - 120, 80, 40);
//    }else if (iphone6){
//        sureBtn.frame = CGRectMake((self.view.width - 200)/3, self.view.height - 120, 100, 40);
//    }else if (iphone6P){
//        sureBtn.frame = CGRectMake((self.view.width - 240)/3, self.view.height - 120, 120, 40);
//    }else if (iphoneX){
//        sureBtn.frame = CGRectMake((self.view.width - 200)/3, self.view.height - 150, 100, 40);
//    }
//    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [sureBtn setBackgroundColor:[UIColor cyanColor]];
//    sureBtn.layer.cornerRadius = 10;
//    sureBtn.clipsToBounds = YES;
//    [self.view addSubview:sureBtn];
//    
//    UPSAlarmBtn *resumeBtn = [[UPSAlarmBtn alloc]init];
//    if (iphone4 || iphone5) {
//        resumeBtn.frame =CGRectMake((self.view.width - 160) / 3 * 2 + 80, self.view.height - 120, 80, 40);
//    }else if (iphone6){
//        resumeBtn.frame = CGRectMake((self.view.width - 200)/ 3 * 2 + 100, self.view.height - 120, 100, 40);
//    }else if (iphone6P){
//        resumeBtn.frame = CGRectMake((self.view.width - 240)/ 3 * 2 + 120, self.view.height - 120, 120, 40);
//    }else if (iphoneX){
//        resumeBtn.frame = CGRectMake((self.view.width - 200)/ 3 * 2 + 100, self.view.height - 150, 100, 40);
//    }
//    [resumeBtn setTitle:@"还原" forState:UIControlStateNormal];
//    [resumeBtn setBackgroundColor:[UIColor cyanColor]];
//    resumeBtn.clipsToBounds = YES;
//    resumeBtn.layer.cornerRadius = 10;
//    [self.view addSubview:resumeBtn];
//    
    
}

- (void)setNontification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickLevelBtn) name:@"didClickLevelBtn" object:nil];
}

- (void)clickLevelBtn{
    UPSAlarmCell *cell = [[UPSAlarmCell alloc]init];
    UIPickerView *pickView = [[UIPickerView alloc]init];
    [self.view addSubview:pickView];
//    [pickView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(cell.levelBtn.mas_bottom).offset(10);
//        make.height.offset(30);
//        make.width.offset(100);
//
//    }];
  
    pickView.frame = CGRectMake(self.view.width / 2, 180, 200, 40);
    pickView.delegate = self;
    pickView.dataSource = self;
  
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark- tableView数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *ID = @"alarmCell";
    UPSAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UPSAlarmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}
#pragma mark- pickView DataSource&delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.data.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.data[component]count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
   
    return self.data[component][row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UPSAlarmCell *cell = [[UPSAlarmCell alloc]init];
    //if (component == 0) {
        [cell.levelBtn setTitle:self.data[component][row] forState:UIControlStateNormal];
       // cell.levelBtn.titleLabel.text = self.data[component][row];
        NSLog(@"点击了1");
    //}else{
        //[cell.levelBtn setTitle:@"哈哈哈" forState:UIControlStateNormal];
        NSLog(@"点击了2");

   // }
}
- (NSArray *)data{
    if (_data == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"alarmLevel.plist" ofType:nil];
        _data = [NSArray arrayWithContentsOfFile:path];
    }
    return _data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
