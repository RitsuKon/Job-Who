//
//  OrderButtonTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/1.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^buttonClicks)(UIButton *button);
@interface OrderButtonTableViewCell : UITableViewCell
@property (copy, nonatomic)buttonClicks buttonBlock;
@end
