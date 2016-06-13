//
//  TelephoneTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/4.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "TelephoneTableViewCell.h"

@interface TelephoneTableViewCell()<UITextFieldDelegate>

@end

@implementation TelephoneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createImage];
        [self createLabel];
        [self createButton];
    }
    return self;
}
- (void)createImage {
    self.teleImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.teleImage];
    
    
}
- (void)createLabel {
    self.teleLabel = [[UILabel alloc] init];
    self.teleLabel.textAlignment = NSTextAlignmentCenter;
    self.teleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.teleLabel];
    
    self.telephone = [[UITextField alloc] init];
    self.telephone.placeholder = @"请输入手机号";
    self.telephone.font = [UIFont systemFontOfSize:12];
    self.telephone.textColor = [UIColor lightGrayColor];
    self.telephone.keyboardType = 4;
    self.telephone.delegate = self;
    [self.contentView addSubview:self.telephone];
    

}
- (void)createButton {
    self.buttonRight = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonRight addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.buttonRight];
}
- (void)button:(UIButton *)button {
    self.block(button);
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    self.beginBlock(textField);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.returnBlock(textField);
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.endBlock(textField);
}
- (void)layoutSubviews {
    [super layoutSubviews];

    self.teleImage.frame = CGRectMake(CWidth * 0.05 + 5, CHeight / 2 - 8, 16, 16);
    self.teleLabel.frame = CGRectMake(CWidth * 0.05 + 21, CHeight / 2 - 10, CWidth * 0.25, 20);
    self.telephone.frame = CGRectMake(CWidth * 0.3 + 26, CHeight / 2 - CHeight * 0.4, CWidth * 0.4, CHeight * 0.8);
    
    self.buttonRight.frame = CGRectMake(CWidth * 0.9 - 16, CHeight / 2 - 8, 16, 16);

    
}

@end
