//
//  ApproveInfoTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/6.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "ApproveInfoTableViewCell.h"

@interface ApproveInfoTableViewCell()<UITextFieldDelegate>

@end

@implementation ApproveInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createLabel];
        [self createTextField];
        [self createImageRight];
        [self createButton];
    }
    return self;
}
- (void)createLabel {
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.title];
    
    self.showLabel = [[UILabel alloc] init];
    self.showLabel.text = @"请选择服务城市(省/市/区)";
    self.showLabel.textColor = [UIColor lightGrayColor];
    self.showLabel.font = [UIFont systemFontOfSize:12];
}
- (void)createTextField {
    self.textField = [[UITextField alloc] init];
    self.textField.font = [UIFont systemFontOfSize:12];
    self.textField.delegate = self;
}
- (void)createImageRight {
    self.imageViewRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail.png"]];
}
- (void)createButton {
    self.buttonRight = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonRight addTarget:self action:@selector(buttonRight:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonRight setImage:[[UIImage imageNamed:@"通讯录.png"] imageWithRenderingMode:1] forState:UIControlStateNormal];
    
    self.subButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.subButton.layer.masksToBounds = YES;
    self.subButton.layer.cornerRadius = 5;
    [self.subButton setTitle:@"立即提交" forState:UIControlStateNormal];
    [self.subButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.subButton setTintColor:[UIColor whiteColor]];
    self.subButton.backgroundColor = Color_System;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (0 == self.myTag) {
        [self.contentView addSubview:self.showLabel];
        [self.contentView addSubview:self.imageViewRight];
        [self.textField removeFromSuperview];
        [self.buttonRight removeFromSuperview];
        [self.subButton removeFromSuperview];
    } else if (1 == self.myTag) {
        [self.contentView addSubview:self.textField];
        [self.showLabel removeFromSuperview];
        [self.imageViewRight removeFromSuperview];
        [self.subButton removeFromSuperview];
        [self.buttonRight removeFromSuperview];
    } else if(2 == self.myTag) {
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.buttonRight];
        [self.showLabel removeFromSuperview];
        [self.imageViewRight removeFromSuperview];
        [self.subButton removeFromSuperview];
    } else {
        [self.contentView addSubview:self.subButton];
        [self.showLabel removeFromSuperview];
        [self.imageViewRight removeFromSuperview];
        [self.buttonRight removeFromSuperview];
        [self.showLabel removeFromSuperview];
    }
    
    self.title.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 10, CWidth * 0.25, 20);
    self.showLabel.frame = CGRectMake(CWidth * 0.25 + 20, CHeight / 2 - 10, CWidth * 0.5, 20);
    self.textField.frame = CGRectMake(CWidth * 0.25 + 20, CHeight / 2 - 10, CWidth * 0.5, 20);
    self.imageViewRight.frame = CGRectMake(CWidth * 0.9, CHeight / 2 - 8, 16, 16);
    self.buttonRight.frame = CGRectMake(CWidth * 0.9, CHeight / 2 - 8, 16, 16);
    self.subButton.frame = CGRectMake(CWidth * 0.2, 0, CWidth * 0.6, CHeight);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.back(textField);
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.end(textField);
}
- (void)buttonRight:(UIButton *)button {
    self.right(button);
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.begin(textField);
}
- (void)click:(UIButton *)button {
    self.buttonBlock(button);
}

@end
