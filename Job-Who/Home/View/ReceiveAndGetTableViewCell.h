//
//  ReceiveAndGetTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/1.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveAndGetTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *addressImage;
@property (strong, nonatomic) UILabel *addressLabel;
@property (strong, nonatomic) UILabel *address;
+ (CGFloat)heightForCell:(NSString *)str;
@end
