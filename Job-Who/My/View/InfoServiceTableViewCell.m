//
//  InfoServiceTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/9.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "InfoServiceTableViewCell.h"

@implementation InfoServiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createLabel];
    }
    return self;
}
- (void)createLabel {
    self.showLabel = [[UILabel alloc] init];
    self.showLabel.font = [UIFont systemFontOfSize:12];
    self.showLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.showLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.showLabel.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 10, CWidth * 0.2, 20);
}
@end
