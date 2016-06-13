//
//  OrderTableViewHeaderFooterView.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/1.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^buttonCancel)(UIButton *button);
@interface OrderCancelView : UIView
@property (copy, nonatomic) buttonCancel block;
@end
