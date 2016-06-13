//
//  TelephoneTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/4.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^buttonClick)(UIButton *button);
typedef void (^textBegin)(UITextField *textField);
typedef void (^textEnding)(UITextField *textField);
typedef void (^textReturn)(UITextField *textField);

@interface TelephoneTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *teleImage;
@property (strong, nonatomic) UILabel *teleLabel;
@property (strong, nonatomic) UITextField *telephone;
@property (strong, nonatomic) UIButton *buttonRight;
@property (copy, nonatomic) buttonClick block;
@property (copy, nonatomic) textBegin beginBlock;
@property (copy, nonatomic) textEnding endBlock;
@property (copy, nonatomic) textReturn returnBlock;
@end
