//
//  SkillSelectTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/8.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SkillDetailTableViewCell;
typedef void (^cellBlock)(SkillDetailTableViewCell *cell);
typedef void (^cellBlockCancel)(SkillDetailTableViewCell *cell);
typedef void (^buttonBlock)(UIButton *button);
@interface SkillSelectTableViewCell : UITableViewCell<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *button;
@property (assign, nonatomic) NSInteger i;//判断是重用哪个cell的样式
@property (strong, nonatomic) NSMutableArray *arrayForRun;//跑腿
@property (strong, nonatomic) NSMutableArray *arrayForHome;//家政
@property (strong, nonatomic) NSMutableArray *arrayForCar;//车辆
@property (copy, nonatomic) cellBlock block;//选择
@property (copy, nonatomic) cellBlockCancel blockCancel;//取消
@property (copy, nonatomic) buttonBlock touchBlock;
@end
