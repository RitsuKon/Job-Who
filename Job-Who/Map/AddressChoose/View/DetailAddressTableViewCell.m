//
//  DetailAddressTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/30.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "DetailAddressTableViewCell.h"

@interface DetailAddressTableViewCell()<UITextFieldDelegate>

@end

@implementation DetailAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createText];
    }
    return self;
}

- (void)createText {
    self.textFieldForAddress = [[UITextField alloc] init];
    self.textFieldForAddress.delegate = self;
    self.textFieldForAddress.clearButtonMode = UITextFieldViewModeAlways;
    self.textFieldForAddress.placeholder = @"楼层/门牌号/公司/店铺(选填)";
    self.textFieldForAddress.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.textFieldForAddress];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.textFieldForAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWidth * 0.95, CHeight));
        make.left.mas_equalTo(self.contentView).with.offset(CWidth *0.05);
        make.top.mas_equalTo(self.contentView).with.offset(0);
        
    }];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textFieldForAddress resignFirstResponder];
    return YES;
}

@end
