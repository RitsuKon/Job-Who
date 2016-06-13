//
//  GoodsTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/3.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "GoodsTableViewCell.h"

@interface GoodsTableViewCell()<UITextFieldDelegate, UITextViewDelegate>

@property (assign, nonatomic) BOOL select1;
@property (assign, nonatomic) BOOL select2;
@end

@implementation GoodsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createImage];
        [self createLabel];
        [self createTextField];
        [self createTextView];
        [self createImageAndButton];

    }
    return self;
}
- (void)createImage {
    self.goodsImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.goodsImage];
    
    self.imageRight = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageRight];
    
}
- (void)createLabel {
    self.goodsLabel = [[UILabel alloc] init];
    self.goodsLabel.textAlignment = NSTextAlignmentCenter;
    self.goodsLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goodsLabel];
    
    self.goodsType = [[UILabel alloc] init];
    self.goodsType.numberOfLines = 0;
    self.goodsType.text = @"点计选择类型";
    self.goodsType.font = [UIFont systemFontOfSize:12];
    self.goodsType.textColor = [UIColor lightGrayColor];
    

    
}
- (void)createTextField {
    self.goodsPrice = [[UITextField alloc] init];
    self.goodsPrice.placeholder = @"请您填写配送物品价值";
    self.goodsPrice.delegate = self;
    self.goodsPrice.keyboardType = UIKeyboardTypeNumberPad
    ;
    self.goodsPrice.font = [UIFont systemFontOfSize:12];
    self.goodsPrice.textColor = [UIColor lightGrayColor];
}
- (void)createTextView {
    self.goodsView = [[UITextView alloc] init];
    self.goodsView.delegate = self;
    self.goodsView.font = [UIFont systemFontOfSize:12];
    self.goodsView.showsHorizontalScrollIndicator = NO;
    self.goodsView.showsVerticalScrollIndicator = NO;
    self.goodsView.textColor = [UIColor lightGrayColor];
//    self.goodsView.backgroundColor = [UIColor redColor];
//    self.goodsView.textAlignment = NSTextAlignmentCenter;
}
- (void)createImageAndButton {
    self.button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button2 = [UIButton buttonWithType:UIButtonTypeSystem];
//    self.button1.titleLabel.textColor = [UIColor lightGrayColor];
//    self.button2.titleLabel.textColor = [UIColor lightGrayColor];
    [self.button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button1 setTitle:@"保温箱" forState:UIControlStateNormal];
    [self.button1 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    self.button1.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.button2 setTitle:@"汽车配送" forState:UIControlStateNormal];
    self.button2.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.button2 addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    self.image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆.png"]];
    self.image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"圆.png"]];
}
- (void)button:(UIButton *)button {
    if (self.button1 == button) {
        self.select1 = !self.select1;
        if (self.select1) {
            self.typeBlock(1);
            self.image1.image = [UIImage imageNamed:@"circle-圆圈.png"];
            [self.button1 setTitleColor:Color_System forState:UIControlStateNormal];
        } else {
            self.typeBlock(2);
            self.image1.image = [UIImage imageNamed:@"圆.png"];
            [self.button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    } else {
        
        self.select2 = !self.select2;
        if (self.select2) {
            self.typeBlock2(1);
            self.image2.image = [UIImage imageNamed:@"circle-圆圈.png"];
            [self.button2 setTitleColor:Color_System forState:UIControlStateNormal];
        } else {
            self.typeBlock2(0);
             self.image2.image = [UIImage imageNamed:@"圆.png"];
            [self.button2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (0 == self.i) {
        [self.contentView addSubview:self.goodsType];

    } else if(1 == self.i) {
        [self.contentView addSubview:self.goodsPrice];

    } else if(2 == self.i) {
        [self.contentView addSubview:self.goodsView];
        [self.contentView addSubview:self.button1];
        [self.contentView addSubview:self.button2];
        [self.contentView addSubview:self.image1];
        [self.contentView addSubview:self.image2];
    } else {
        [self.contentView addSubview:self.goodsView];
    }
    self.goodsImage.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 8, 16, 16);
    self.goodsLabel.frame = CGRectMake(CWidth * 0.05 + 16, CHeight / 2 - 10, CWidth * 0.2, 20);
    self.goodsType.frame = CGRectMake(CWidth * 0.25 + 16, CHeight / 2 - CHeight * 0.4, CWidth * 0.4, CHeight * 0.8);
    self.goodsPrice.frame = CGRectMake(CWidth * 0.25 + 16, CHeight / 2 - CHeight * 0.4, CWidth * 0.4, CHeight * 0.8);
    self.imageRight.frame = CGRectMake(CWidth * 0.9 - 16, CHeight / 2 - 8, 16, 16);
    self.goodsView.frame = CGRectMake(CWidth * 0.25 + 16, CHeight / 2 - CHeight * 0.45, CWidth * 0.8, CHeight * 0.7);

    
    self.image1.frame = CGRectMake(CWidth * 0.1, CHeight * 0.9 - 8, 16, 16);
    self.button1.frame = CGRectMake(CWidth * 0.1 + 16, CHeight * 0.9 - 8, CWidth * 0.2, 16);
    self.image2.frame = CGRectMake(CWidth * 0.7 - 16 , CHeight * 0.9 - 8, 16, 16);
    self.button2.frame = CGRectMake(CWidth * 0.7, CHeight * 0.9 - 8, CWidth * 0.2, 16);
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"订单物品信息补充:如配送要求,配送方式"] || [textView.text isEqualToString:@"排队占座, 医院挂号, 通通帮你搞定"]) {
        textView.text = @"";
    }
    self.block(textView);
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"订单物品信息补充:如配送要求,配送方式";
    }
    self.textViewBlock(textView);
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        self.blockBack(textView);
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.priceBlock(textField);
}

+ (CGFloat)heightForCell:(NSString *)str {
    CGRect rect = [str boundingRectWithSize:CGSizeMake(Width * 0.6, 0) options:1 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.height + Height * 0.07 * 0.2;
}


@end
