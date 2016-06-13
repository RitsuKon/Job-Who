//
//  AddressLocationTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/1.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "AddressLocationTableViewCell.h"

@interface AddressLocationTableViewCell()

@end

@implementation AddressLocationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createImageView];
        [self createLabel];
    }
    return self;
}

- (void)createImageView {
    self.addressImage = [[UIImageView alloc] init];

    [self.contentView addSubview:self.addressImage];
}

- (void)createLabel {
    self.labelType = [[UILabel alloc] init];
    self.labelType.textAlignment = NSTextAlignmentCenter;
    self.labelType.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.labelType];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.numberOfLines = 0;
    self.addressLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.addressLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CHeight * 0.4, CHeight * 0.4));
        make.left.mas_equalTo(self.contentView).with.offset(CWidth * 0.05);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight * 0.3);
    }];
    
    [self.labelType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWidth * 0.3, CHeight * 0.4));
        make.left.mas_equalTo(self.contentView).with.offset(CWidth * 0.05 + CHeight * 0.4);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight * 0.3);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWidth * 0.6 - CHeight * 0.4, CHeight * 0.8));
        make.right.mas_equalTo(self.contentView).with.offset(CWidth * -0.05);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight * 0.1);
    }];
}

@end
