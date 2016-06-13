//
//  IdentityTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/6.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "IdentityTableViewCell.h"

@interface IdentityTableViewCell()
@property (strong, nonatomic) UIImageView *myImageView;
@end

@implementation IdentityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createImageView];
        [self createButton];
    }
    return self;
}
- (void)createImageView {
    for (int i = 0; i < 3; i ++) {
        self.myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aa.png"]];
        self.myImageView.tag = 500 + i;
//        self.myImageView.frame = CGRectMake(Width * 0.05, Height * 0.5 * 0.05 * (i + 1) + (Width * 0.85 / 2) * i, Width * 0.85 / 2, Width * 0.85 / 2);
        [self.contentView addSubview:self.myImageView];
        self.myImageView.backgroundColor = [UIColor redColor];
    }
}
- (void)createButton {

        self.buttonPhoto1 = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.buttonPhoto1 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.buttonPhoto1];
        self.buttonPhoto1.backgroundColor = [UIColor yellowColor];
    self.buttonPhoto1.tag = 101;
    
    self.buttonPhoto2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonPhoto2 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.buttonPhoto2];
    self.buttonPhoto2.backgroundColor = [UIColor yellowColor];
    self.buttonPhoto2.tag = 102;
    self.buttonPhoto3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonPhoto3 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.buttonPhoto3];
    self.buttonPhoto3.backgroundColor = [UIColor yellowColor];
    self.buttonPhoto3.tag = 103;
    
}
- (void)button:(UIButton *)button {
    self.block(button);
}
- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i < 3; i ++) {
        self.myImageView = [self.contentView viewWithTag:500 + i];
       self.myImageView.frame = CGRectMake(CWidth * 0.05, CWidth * 0.05 * (i + 1) + (CWidth * 0.85 / 2) * i, CWidth * 0.85 / 2, CWidth * 0.85 / 2);
    }

        self.buttonPhoto1.frame = CGRectMake(CWidth * 0.1 + CWidth * 0.85 / 2, CWidth * 0.05, CWidth * 0.85 / 2, CWidth * 0.85 / 2);
        self.buttonPhoto2.frame = CGRectMake(CWidth * 0.1 + CWidth * 0.85 / 2, CWidth * 0.1 + (CWidth * 0.85 / 2), CWidth * 0.85 / 2, CWidth * 0.85 / 2);
        self.buttonPhoto3.frame = CGRectMake(CWidth * 0.1 + CWidth * 0.85 / 2, CWidth * 0.15 + (CWidth * 0.85 / 2) * 2, CWidth * 0.85 / 2, CWidth * 0.85 / 2);
    
}

@end
