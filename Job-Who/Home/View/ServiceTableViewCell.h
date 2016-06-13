//
//  ServiceTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/4.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^moneyBlock)(UITextField *text);
typedef void (^cancelBlock)(UITextField *text);
typedef void (^changeBlock)(UITextField *text);
typedef void (^buttonClick)(UIButton *button);
@interface ServiceTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *labelTitle;
@property (strong, nonatomic) UIImageView *moneyImageView;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UITextField *moneyText;
@property (strong, nonatomic) UILabel *lineLabel;
@property (strong, nonatomic) UIImageView *imageRight;
@property (strong, nonatomic) UIButton *submitButton;
@property (assign, nonatomic) NSInteger i;
@property (copy, nonatomic) moneyBlock block;
@property (copy, nonatomic) cancelBlock endBlock;
@property (copy, nonatomic) changeBlock cBlock;
@property (copy, nonatomic) buttonClick buttonBlock;
@end
