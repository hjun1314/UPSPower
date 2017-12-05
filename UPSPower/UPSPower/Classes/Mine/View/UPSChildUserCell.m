//
//  UPSChildUserCell.m
//  UPSPower
//
//  Created by hjun on 2017/11/29.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSChildUserCell.h"

@implementation UPSChildUserCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup{
     UITextField *nameLabel = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, kScreenW / 3, self.height)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.borderStyle = UITextBorderStyleNone;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.userInteractionEnabled = NO;
    self.nameLabel = nameLabel;
     [self.contentView addSubview:nameLabel];
    
    UITextField *passwordLabel = [[UITextField alloc]initWithFrame:CGRectMake(kScreenW / 3, 0, kScreenW / 3, self.height)];
    passwordLabel.borderStyle = UITextBorderStyleNone;
    passwordLabel.secureTextEntry = YES;
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    passwordLabel.userInteractionEnabled = NO;
    self.passwordLabel = passwordLabel;
    [self.contentView addSubview:passwordLabel];
    
    UIButton *fixBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenW / 3)*2, 0, kScreenW / 6, self.height)];
    //[fixBtn setBackgroundImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [fixBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [fixBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.contentView addSubview:fixBtn];
    
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenW / 3) * 2 + kScreenW /6, 0, kScreenW / 6, self.height)];
    [deleteBtn setImage:[UIImage imageNamed:@"remove"] forState:UIControlStateNormal];
    [self.contentView addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)clickDeleteBtn{
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"didDeleteBtn" object:nil];
    if (self.btnClick) {
        self.btnClick();
    }
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
