//
//  BuyTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/8.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^tableSelect)(UITableView *table);
typedef void (^tableNo)(NSString *str);
@interface BuyTableViewCell : UITableViewCell
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) NSInteger addressTag;
@property (strong, nonatomic) UITableView *selectTableView;
@property (copy, nonatomic) tableSelect info;
@property (copy, nonatomic) tableNo noSelect;

@end
