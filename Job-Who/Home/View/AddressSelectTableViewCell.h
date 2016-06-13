//
//  AddressSelectTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/8.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressSelectTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *correctImageView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *selectLabel;
@property (assign, nonatomic) NSInteger i;
+ (CGFloat)heightForCell:(NSString *)text;
@end
