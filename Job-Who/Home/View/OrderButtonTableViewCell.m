//
//  OrderButtonTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/1.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "OrderButtonTableViewCell.h"

@interface OrderButtonTableViewCell()
@property (strong, nonatomic) UIButton *buttonClick;
@end

@implementation OrderButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createButton];
    }
    return self;
}
- (void)createButton {
    self.buttonClick = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonClick setTintColor:[UIColor whiteColor]];
    self.buttonClick.backgroundColor = Color_System;
    [self.buttonClick setTitle:@"下单" forState:UIControlStateNormal];
    self.buttonClick.layer.masksToBounds = YES;
    self.buttonClick.layer.cornerRadius = 5;
    [self.buttonClick addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.buttonClick];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.buttonClick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWidth * 0.3, CHeight * 0.8));
        make.left.mas_equalTo(self.contentView).with.offset(CWidth * 0.35);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight * 0.1);
    }];
}
- (void)button:(UIButton *)button {
    self.buttonBlock(button);
}
@end
