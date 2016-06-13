//
//  AddressTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/27.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "AddressTableViewCell.h"

@interface AddressTableViewCell()
@property (strong, nonatomic) UIButton *detailButton;

@end

@implementation AddressTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createImage];
        [self createLabel];
        [self createButton];
        
    }
    return self;
}

#pragma mark - image
- (void)createImage {

    self.selectedImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"定位灰.png"]];
    [self.contentView addSubview:self.selectedImage];
}

#pragma mark - label
- (void)createLabel {
    self.address = [[UILabel alloc] init];
    [self.contentView addSubview:self.address];
    self.address.textColor = [UIColor lightGrayColor];
    self.address.font = [UIFont systemFontOfSize:15];
}

#pragma mark - button
- (void)createButton {
    self.detailButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.detailButton setImage:[[UIImage imageNamed:@"detail.png"] imageWithRenderingMode:1]forState:UIControlStateNormal];
    [self.detailButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.detailButton];
}

- (void)button:(UIButton *)button {
//    self.block(button);
    self.blockInfo(self.poiInfo);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.selectedImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.left.mas_equalTo(self.contentView).with.offset(CWidth * 0.05);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight / 2 - 8);
        
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWidth * 0.8 - 32, 16));
        make.left.mas_equalTo(self.contentView).with.offset(CWidth * 0.1 + 16);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight / 2 - 8);
        
    }];
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(16, 16));
        make.right.mas_equalTo(self.contentView).with.offset(-CWidth * 0.1);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight / 2 - 8);
        
    }];

}


@end
