//
//  SkillDetailTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/9.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "SkillDetailTableViewCell.h"

@implementation SkillDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createLabel];
        [self createImageView];
    }
    return self;
}
- (void)createLabel {
    self.skillLabel = [[UILabel alloc] init];
    self.skillLabel.font = [UIFont systemFontOfSize:12];
    self.skillLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.skillLabel];
}
- (void)createImageView {
    self.selectImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.selectImageView];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.skillLabel.frame = CGRectMake(CWidth * 0.05, CHeight* 0.1, CWidth * 0.5, CHeight * 0.8);
    self.selectImageView.frame = CGRectMake(CWidth * 0.9, CHeight / 2 - 8, 16, 16);
    
}

@end
