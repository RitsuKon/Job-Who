//
//  MyServiceTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/9.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "MyServiceTableViewCell.h"

@interface MyServiceTableViewCell()
@property (strong, nonatomic) UIImageView *bigImageView;
@property (strong, nonatomic) UIView *userView;
@property (strong, nonatomic) UIImageView *userImageView;
@property (strong, nonatomic) UILabel *userLabel;

@property (strong, nonatomic) UIImageView *sexImage;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UIImageView *touchLabel;
@property (strong, nonatomic) UIImageView *touchLabel2;
@property (strong, nonatomic) UIImageView *identityImage;
@property (strong, nonatomic) UIImageView *starImage1;
@property (strong, nonatomic) UIImageView *starImage2;
@property (strong, nonatomic) UIImageView *starImage3;
@property (strong, nonatomic) UIImageView *starImage4;
@property (strong, nonatomic) UIImageView *starImage5;
@property (strong, nonatomic) UILabel *identityLabel;
@property (strong, nonatomic) UILabel *rateLabel;
@property (strong, nonatomic) UILabel *serviceLabel;
@property (strong, nonatomic) UILabel *serviceNumber;
@property (strong, nonatomic) UILabel *rankLabel;
@property (strong, nonatomic) UILabel *rank;

@end

@implementation MyServiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createImageView];
        [self createLabel];
    }
    return self;
}
- (void)createImageView {
    self.userView = [[UIView alloc] init];
    self.userView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    self.bigImageView = [[UIImageView alloc] init];
    self.bigImageView.backgroundColor = [UIColor redColor];
    
    self.userImageView = [[UIImageView alloc] init];
    self.userImageView.backgroundColor = [UIColor yellowColor];
    self.userImageView.layer.masksToBounds = YES;
    
    
    self.sexImage = [[UIImageView alloc] init];
    self.sexImage.backgroundColor = [UIColor blueColor];
    
    self.identityImage = [[UIImageView alloc] init];
    self.identityImage.image = [UIImage imageNamed:@"身份.png"];
    
    self.starImage1 = [[UIImageView alloc] init];
    self.starImage2 = [[UIImageView alloc] init];
    self.starImage3 = [[UIImageView alloc] init];
    self.starImage4 = [[UIImageView alloc] init];
    self.starImage5 = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.bigImageView];
    [self.userView addSubview:self.userImageView];
    [self.userView addSubview:self.sexImage];
    [self.contentView addSubview:self.identityImage];
    
    [self.contentView addSubview:self.starImage1];
    [self.contentView addSubview:self.starImage2];
    [self.contentView addSubview:self.starImage3];
    [self.contentView addSubview:self.starImage4];
    [self.contentView addSubview:self.starImage5];
    
    
    [self.bigImageView addSubview:self.userView];
    
}
- (void)createLabel {
    self.userLabel = [[UILabel alloc] init];
    self.userLabel.textColor = [UIColor whiteColor];
    self.userLabel.font = [UIFont systemFontOfSize:15];
    [self.userView addSubview:self.userLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.textColor = [UIColor whiteColor];
    self.addressLabel.font = [UIFont systemFontOfSize:12];
    [self.userView addSubview:self.addressLabel];
    
    self.workLabel = [[UILabel alloc] init];
    self.workLabel.textColor = [UIColor whiteColor];
    self.workLabel.font = [UIFont systemFontOfSize:12];
    self.workLabel.layer.masksToBounds = YES;
    self.workLabel.layer.cornerRadius = 5;
    self.workLabel.text = @"开工中";
    self.workLabel.backgroundColor= Color_System;
    self.workLabel.textAlignment = NSTextAlignmentCenter;
    [self.userView addSubview:self.workLabel];
    
    
//    self.touchLabel.textColor = [UIColor whiteColor];
//    self.touchLabel.text = @".";
//    self.touchLabel.textAlignment = NSTextAlignmentCenter;
    for (int i = 0; i < 5; i ++) {
        self.touchLabel = [[UIImageView alloc] init];
        self.touchLabel.tag = 100 + i;
        self.touchLabel.image = [UIImage imageNamed:@"点.png"];
        [self.userView addSubview:self.touchLabel];
    }
    

    for (int j = 0; j < 6; j ++) {
        self.touchLabel2 = [[UIImageView alloc] init];
        self.touchLabel2.tag = 200 + j;
        self.touchLabel2.image = [UIImage imageNamed:@"点 (1).png"];
//        self.touchLabel2.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.touchLabel2];
    }
    
    self.identityLabel = [[UILabel alloc] init];
    self.identityLabel.textColor = [UIColor lightGrayColor];
    self.identityLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.identityLabel];
    
    self.rateLabel = [[UILabel alloc] init];
    self.rateLabel.font = [UIFont systemFontOfSize:12];
    self.rateLabel.textColor = [UIColor lightGrayColor];
    self.rateLabel.text = @"服务评价";
    [self.contentView addSubview:self.rateLabel];
    
    self.serviceLabel = [[UILabel alloc] init];
    self.serviceLabel.textColor = [UIColor lightGrayColor];
    self.serviceLabel.text = @"服务过";
    self.serviceLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.serviceLabel];
    
    self.rankLabel = [[UILabel alloc] init];
    self.rankLabel.textColor = [UIColor lightGrayColor];
    self.rankLabel.text = @"骑士排名";
    self.rankLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.rankLabel];
    
    self.rank = [[UILabel alloc] init];
    self.rank.font = [UIFont systemFontOfSize:13];
    self.rank.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.rank];
    
    self.serviceNumber = [[UILabel alloc] init];
    self.serviceNumber.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.serviceNumber];
    
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bigImageView.frame = CGRectMake(0, 0, CWidth, CHeight * 0.7);
    self.bigImageView.image = [UIImage imageNamed:@"timg.jpeg"];
    self.userView.frame = CGRectMake(0, self.bigImageView.frame.size.height * 0.7, CWidth, self.bigImageView.frame.size.height * 0.3);
    self.userImageView.frame = CGRectMake(UserWidth * 0.05, UserHeight * 0.1, UserHeight * 0.8, UserHeight * 0.8);
    self.userImageView.layer.cornerRadius = UserHeight * 0.4;
    
    self.userLabel.text = @"孙师傅aaaa";
    CGRect userRect =[self.userLabel.text boundingRectWithSize:CGSizeMake(UserWidth * 0.6, UserHeight * 0.25) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    self.userLabel.frame = CGRectMake(UserWidth * 0.05 +UserHeight * 0.8 + 5, UserHeight * 0.15, userRect.size.width, UserHeight * 0.25);
    self.sexImage.frame = CGRectMake(UserWidth * 0.05 + UserHeight * 0.8 + 5 + userRect.size.width, UserHeight * 0.15, UserHeight * 0.25, UserHeight * 0.25);
    
    self.addressLabel.text = @"辽宁--营口市--大石桥市";
    CGRect addressRect = [self.addressLabel.text boundingRectWithSize:CGSizeMake(UserWidth * 0.55, UserHeight * 0.25) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    self.addressLabel.frame = CGRectMake(UserWidth * 0.05 +UserHeight * 0.8 + 5, UserHeight * 0.5, addressRect.size.width, UserHeight * 0.25);
    
    for (int i = 0; i < 5; i ++) {
        self.touchLabel = [self.contentView viewWithTag:100 + i];
        self.touchLabel.frame = CGRectMake(UserWidth * 0.6 +UserHeight * 0.8 + 5, 5 *(i+1) + 5 * i, 5, 5);
        
    }
    for (int j = 0; j < 6; j ++) {
        self.touchLabel2 = [self.contentView viewWithTag:200 + j];
        self.touchLabel2.frame = CGRectMake(CWidth * 0.47 - 2, CHeight * 0.85 + 6 * j, 5, 5);
    }
    self.workLabel.frame = CGRectMake(UserWidth * 0.6 +UserHeight * 0.8 + 12, UserHeight * 0.25, UserWidth * 0.2, UserHeight * 0.5);
    if (1 == self.i) {
        self.workLabel.text = @"开工中";
        self.workLabel.backgroundColor= Color_System;
    } else {
        self.workLabel.text = @"休息中";
        self.workLabel.backgroundColor= [UIColor lightGrayColor];
    }
    
    self.identityImage.frame = CGRectMake(CWidth * 0.05, CHeight * 0.75, 20, 20);
    
    self.identityLabel.text = @"已认证";
    self.identityLabel.frame = CGRectMake(CWidth * 0.05 + 21, CHeight * 0.75, CWidth * 0.2, 20);
    self.rateLabel.frame = CGRectMake(CWidth * 0.5, CHeight * 0.75, CWidth * 0.15, 20);
    self.starImage1.frame = CGRectMake(CWidth * 0.68, CHeight * 0.75+2, 16, 16);
    self.starImage2.frame = CGRectMake(CWidth * 0.68+16, CHeight * 0.75+2, 16, 16);
    self.starImage3.frame = CGRectMake(CWidth * 0.68+32, CHeight * 0.75+2, 16, 16);
    self.starImage4.frame = CGRectMake(CWidth * 0.68+48, CHeight * 0.75+2, 16, 16);
    self.starImage5.frame = CGRectMake(CWidth * 0.68+64, CHeight * 0.75+2, 16, 16);
    self.starImage1.backgroundColor = [UIColor redColor];
    self.starImage2.backgroundColor = [UIColor blueColor];
    self.starImage3.backgroundColor = [UIColor yellowColor];
    self.starImage4.backgroundColor = [UIColor grayColor];
    self.starImage5.backgroundColor = [UIColor blackColor];
    
    
    self.serviceNumber.text = @"189";
    self.rank.text = @"2223";
//    self.serviceNumber.textAlignment = NSTextAlignmentCenter;

    self.rankLabel.frame = CGRectMake(CWidth * 0.6, CHeight * 0.9, CWidth * 0.2, 20);
    [self.serviceNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWidth * 0.2, 20));
        make.left.mas_equalTo(self.contentView).with.offset(CWidth * 0.225);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight * 0.85);
    }];
    
    [self.serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWidth * 0.2, 20));
        make.left.mas_equalTo(self.contentView).with.offset(CWidth * 0.2);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight * 0.9);
    }];
    
    [self.rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWidth * 0.2, 20));
        make.right.mas_equalTo(self.contentView).with.offset(CWidth * -0.225);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight * 0.85);
    }];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWidth * 0.2, 20));
        make.right.mas_equalTo(self.contentView).with.offset(CWidth * -0.15);
        make.top.mas_equalTo(self.contentView).with.offset(CHeight * 0.9);
    }];
    

    
    

    
    
}

@end
