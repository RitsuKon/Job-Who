//
//  AddressSelectTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/8.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "AddressSelectTableViewCell.h"

@interface AddressSelectTableViewCell()
@property (strong, nonatomic) UIImageView *imageRight;
@end

@implementation AddressSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createImage];
        [self createLabel];
    }
    return self;
}
- (void)createImage {
    self.correctImageView = [[UIImageView alloc] init];
    self.imageRight = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"detail.png"] imageWithRenderingMode:1]];
}
- (void)createLabel {
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:12];
    
    self.selectLabel = [[UILabel alloc] init];
    self.selectLabel.numberOfLines = 0;
//    self.selectLabel.backgroundColor = [UIColor redColor];
    self.selectLabel.font = [UIFont systemFontOfSize:12];
    self.selectLabel.textColor = [UIColor lightGrayColor];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (0 == self.i) {
        [self.contentView addSubview:self.correctImageView];
        [self.contentView addSubview:self.label];
        [self.selectLabel removeFromSuperview];
        [self.imageRight removeFromSuperview];
    } else {
        [self.correctImageView removeFromSuperview];
        [self.label removeFromSuperview];
        [self.contentView addSubview:self.selectLabel];
        [self.contentView addSubview:self.imageRight];
    }
    self.correctImageView.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 8, 16, 16);
    self.label.frame = CGRectMake(CWidth * 0.05 + 21, CHeight / 2 - 10, CWidth * 0.5, 20);
    CGRect rect = [self.selectLabel.text boundingRectWithSize:CGSizeMake(CWidth * 0.89 - 16, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    self.selectLabel.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - rect.size.height / 2, CWidth * 0.89 - 16, rect.size.height);
    self.imageRight.frame = CGRectMake(CWidth * 0.84, CHeight / 2 - 8, 16, 16);
}

+ (CGFloat)heightForCell:(NSString *)text {
    CGRect rect = [text boundingRectWithSize:CGSizeMake((Width * 0.75 - 26) * 0.5, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.height;
}

@end
