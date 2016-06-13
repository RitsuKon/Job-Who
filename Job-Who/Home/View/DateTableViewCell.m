//
//  DateTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/2.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "DateTableViewCell.h"

@interface DateTableViewCell()

@property (strong, nonatomic) UIImageView *timeImage;
@property (strong, nonatomic) UIImageView *imageRight;


@end

@implementation DateTableViewCell

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
    self.timeImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"时间.png"]];
    [self.contentView addSubview:self.timeImage];
    
    self.imageRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail.png"]];
    [self.contentView addSubview:self.imageRight];
    
}
- (void)createLabel {
    self.timeLabel = [[UILabel alloc] init];
   
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.timeLabel];
    
    self.time = [[UILabel alloc] init];
    self.time.numberOfLines = 0;
//    self.time.text = @"请选择取货时间";
    self.time.font = [UIFont systemFontOfSize:12];
    self.time.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.time];
    

}
- (void)createButton {
    self.buttonReceive = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonReceive setTintColor:[UIColor whiteColor]];
    self.buttonReceive.backgroundColor = Color_System;
    self.buttonReceive.layer.masksToBounds = YES;
    self.buttonReceive.layer.cornerRadius = 5;
//    [self.buttonReceive setTitle:@"立即取货" forState:UIControlStateNormal];
    self.buttonReceive.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.buttonReceive addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.buttonReceive];
}
- (void)button:(UIButton *)button {
    self.block(button);
}
- (void)layoutSubviews {
    [super layoutSubviews];

    self.timeImage.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 8, 16, 16);
    self.timeLabel.frame = CGRectMake(CWidth * 0.05 + 16, CHeight / 2 - 10, CWidth * 0.2, 20);
    self.time.frame = CGRectMake(CWidth * 0.25 + 16, CHeight / 2 - CHeight * 0.4, CWidth * 0.4, CHeight * 0.8);
    
    self.imageRight.frame = CGRectMake(CWidth * 0.9 - 16, CHeight / 2 - 8, 16, 16);
    self.buttonReceive.frame = CGRectMake(CWidth * 0.7 - 16, CHeight * 0.1, CWidth * 0.2, CHeight * 0.8);

    
}


@end
