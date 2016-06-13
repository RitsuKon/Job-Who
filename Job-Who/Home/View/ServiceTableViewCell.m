//
//  ServiceTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/4.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "ServiceTableViewCell.h"

@interface ServiceTableViewCell()<UITextFieldDelegate>

@end

@implementation ServiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createImage];
        [self createLabel];
        [self createTextField];
        [self createButton];
    }
    return self;
}

- (void)createImage {
    self.moneyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"钱.png"]];
    self.imageRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"元.png"]];
}
- (void)createLabel {
    self.labelTitle = [[UILabel alloc] init];
    self.labelTitle.font = [UIFont systemFontOfSize:12];
    self.lineLabel = [[UILabel alloc] init];
    self.lineLabel.textColor = [UIColor lightGrayColor];
    self.lineLabel.font = [UIFont systemFontOfSize:12];
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.textColor = [UIColor orangeColor];
    self.moneyLabel.font = [UIFont systemFontOfSize:12];
}
- (void)createTextField {
    self.moneyText = [[UITextField alloc] init];
    self.moneyText.delegate = self;
    self.moneyText.keyboardType = 4;
    self.moneyText.textColor = [UIColor lightGrayColor];
    self.moneyText.font = [UIFont systemFontOfSize:12];
}
- (void)createButton {
    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.submitButton setTintColor:[UIColor whiteColor]];
    [self.submitButton setTitle:@"生成订单" forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.backgroundColor = Color_System;
    self.submitButton.layer.masksToBounds = YES;
    self.submitButton.layer.cornerRadius = 5;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (0 == self.i) {
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.moneyImageView];
        [self.contentView addSubview:self.moneyLabel];
        [self.contentView addSubview:self.lineLabel];
        self.labelTitle.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 10, CWidth * 0.15, 20);
        self.moneyImageView.frame = CGRectMake(CWidth * 0.2, CHeight / 2 - 8, 16, 16);
        self.moneyLabel.frame = CGRectMake(CWidth * 0.2 + 16, CHeight / 2 - 10, CWidth * 0.2, 20);
    } else if (1 == self.i) {
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.moneyText];
        [self.contentView addSubview:self.imageRight];
        self.labelTitle.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 10, CWidth * 0.15, 20);
        self.moneyImageView.frame = CGRectMake(CWidth * 0.2, CHeight / 2 - 8, 16, 16);
    } else if (2 == self.i) {
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.moneyImageView];
        [self.contentView addSubview:self.moneyLabel];
        self.labelTitle.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 5, CWidth * 0.15, 20);
        self.moneyImageView.frame = CGRectMake(CWidth * 0.2, CHeight / 2 - 4, 16, 16);
        self.moneyLabel.frame = CGRectMake(CWidth * 0.2 + 16, CHeight / 2 - 5, CWidth * 0.2, 20);

    } else {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.submitButton];
    }
//    self.labelTitle.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 10, CWidth * 0.15, 20);
//    self.moneyImageView.frame = CGRectMake(CWidth * 0.2, CHeight / 2 - 8, 16, 16);
//    self.moneyLabel.frame = CGRectMake(CWidth * 0.2 + 16, CHeight / 2 - 10, CWidth * 0.2, 20);
    self.lineLabel.frame = CGRectMake(CWidth * 0.4 + 21, CHeight / 2 - 10, CWidth * 0.3, 20);
    self.moneyText.frame = CGRectMake(CWidth * 0.3, CHeight / 2 - 10, CWidth * 0.5, 20);
    self.imageRight.frame = CGRectMake(CWidth * 0.9 - 16, CHeight / 2 - 8, 16, 16);
    self.submitButton.frame = CGRectMake(CWidth * 0.2, 0, CWidth * 0.6, CHeight);
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.block(textField);
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.endBlock(textField);
}
- (void)button:(UIButton *)button {
    self.buttonBlock(button);
}


@end
