//
//  GoodsTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/3.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^textBlock)(UITextView *textView);
typedef void (^priceBlock)(UITextField *textField);
typedef void (^returnBlock)(UITextView *textView);
typedef void (^typeBlock)(NSInteger i);
typedef void (^typeBlock2)(NSInteger i);
typedef void (^viewBlock)(UITextView *textView);
@interface GoodsTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *goodsImage;
@property (strong, nonatomic) UILabel *goodsLabel;
@property (strong, nonatomic) UILabel *goodsType;
@property (strong, nonatomic) UITextField *goodsPrice;
@property (strong, nonatomic) UIImageView *imageRight;
@property (assign, nonatomic) NSInteger i;
@property (strong, nonatomic) UITextView *goodsView;
@property (copy, nonatomic) textBlock block;
@property (copy, nonatomic) returnBlock blockBack;
@property (copy, nonatomic) typeBlock typeBlock;
@property (copy, nonatomic) typeBlock2 typeBlock2;
@property (copy, nonatomic) priceBlock priceBlock;
@property (copy, nonatomic) viewBlock textViewBlock;
@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UIImageView *image1;
@property (strong, nonatomic) UIImageView *image2;

+ (CGFloat)heightForCell:(NSString *)str;
@end
