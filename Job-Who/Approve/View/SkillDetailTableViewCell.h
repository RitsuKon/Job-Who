//
//  SkillDetailTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/9.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillDetailTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *skillLabel;
@property (strong, nonatomic) UIImageView *selectImageView;
@property (assign, nonatomic) NSInteger i;//判断是哪个技能标签下的技能
@property (assign, nonatomic) NSInteger j;//判断是技能标签下的哪个技能
@end
