//
//  ReceiveAndGetTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/1.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "ReceiveAndGetTableViewCell.h"

@interface ReceiveAndGetTableViewCell()
@property (strong, nonatomic) UIImageView *imageRight;
@end

@implementation ReceiveAndGetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createImage];
        [self createLabel];
    }
    return self;
}
- (void)createImage {
    self.addressImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.addressImage];
    
    self.imageRight = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detail.png"]];
    [self.contentView addSubview:self.imageRight];
    
}
- (void)createLabel {
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    self.addressLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.addressLabel];
    
    self.address = [[UILabel alloc] init];
    self.address.numberOfLines = 0;
    self.address.font = [UIFont systemFontOfSize:12];
    self.address.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.address];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = [self.address.text boundingRectWithSize:CGSizeMake(CWidth * 0.55, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    self.addressImage.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 8, 16, 16);
    self.addressLabel.frame = CGRectMake(CWidth * 0.05 + 16, CHeight / 2 - 10, CWidth * 0.2, 20);
    self.address.frame = CGRectMake(CWidth * 0.25 + 16, CHeight / 2 - rect.size.height / 2, CWidth * 0.55, rect.size.height);
    
    self.imageRight.frame = CGRectMake(CWidth * 0.9 - 16, CHeight / 2 - 8, 16, 16);


}

+ (CGFloat)heightForCell:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(Width * 0.6, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.height + Height * 0.07 * 0.2;
}

@end
