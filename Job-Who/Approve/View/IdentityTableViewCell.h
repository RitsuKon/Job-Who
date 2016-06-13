//
//  IdentityTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/6.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^buttonBlock)(UIButton *button);

@interface IdentityTableViewCell : UITableViewCell
@property (strong, nonatomic) UIButton *buttonPhoto1;
@property (strong, nonatomic) UIButton *buttonPhoto2;
@property (strong, nonatomic) UIButton *buttonPhoto3;
@property (copy, nonatomic) buttonBlock block;
@end
