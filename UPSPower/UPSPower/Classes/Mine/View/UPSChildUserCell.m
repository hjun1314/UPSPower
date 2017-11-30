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
     UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW / 3, 30)];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel = nameLabel;
     [self addSubview:nameLabel];
    
    UILabel *passwordLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW / 3, 0, kScreenW / 3, 30)];
    passwordLabel.textAlignment = NSTextAlignmentCenter;
    self.passwordLabel = passwordLabel;
    [self addSubview:passwordLabel];
    
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenW / 3)*2, 0, kScreenW / 3, 30)];
    [self addSubview:deleteBtn];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
