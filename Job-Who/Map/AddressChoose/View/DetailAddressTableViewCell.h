//
//  DetailAddressTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/5/30.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TextBlock)(UITextField *textField);
@interface DetailAddressTableViewCell : UITableViewCell
@property (copy, nonatomic) TextBlock block;
@property (strong, nonatomic) UITextField *textFieldForAddress;
@end
