//
//  DateTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/2.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^buttonClick)(UIButton *button);

@interface DateTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *timeLabel;
@property (copy, nonatomic) buttonClick block;
@property (strong, nonatomic) UIButton *buttonReceive;
@end
