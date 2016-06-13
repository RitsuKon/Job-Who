//
//  ApproveInfoTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/6.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^endBlock)(UITextField *text);
typedef void (^backBlock)(UITextField *text);
typedef void (^beginBlock)(UITextField *text);
typedef void (^rightBlock)(UIButton *button);
typedef void (^buttonClick)(UIButton *button);

@interface ApproveInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *showLabel;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIImageView *imageViewRight;
@property (strong, nonatomic) UIButton *buttonRight;
@property (assign, nonatomic) NSInteger myTag;
@property (strong, nonatomic) UIButton *subButton;
@property (copy, nonatomic) endBlock end;
@property (copy, nonatomic) backBlock back;
@property (copy, nonatomic) beginBlock begin;
@property (copy, nonatomic) rightBlock right;
@property (copy, nonatomic) buttonClick buttonBlock;
@end
