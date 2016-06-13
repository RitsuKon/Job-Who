//
//  SkillSelectTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/8.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "SkillSelectTableViewCell.h"

@interface SkillSelectTableViewCell()
@property (assign, nonatomic)BOOL switchCell;
@end

@implementation SkillSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self createTableView];
        [self createButton];
    }
    return self;
}
- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CWidth, CHeight) style:0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView registerClass:[SkillDetailTableViewCell class] forCellReuseIdentifier:@"skill"];
//    [self.contentView addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == self.i) {
        return self.arrayForRun.count;
    } else if (1 == self.i) {
        return self.arrayForHome.count;
    } else {
        return self.arrayForCar.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SkillDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"skill"];
    cell.selectionStyle = 0;
        if (0 == self.i) {
            cell.skillLabel.text = self.arrayForRun[indexPath.row];
            cell.selectImageView.image = [UIImage imageNamed:@"圆.png"];
        } else if (1 == self. i) {
            cell.skillLabel.text = self.arrayForHome[indexPath.row];
            cell.selectImageView.image = [UIImage imageNamed:@"圆.png"];
            
        } else {
            cell.skillLabel.text = self.arrayForCar[indexPath.row];
            cell.selectImageView.image = [UIImage imageNamed:@"圆.png"];
        }


    return cell;
}
- (void)createButton {
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.backgroundColor = Color_System;
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5;
    [self.button setTitle:@"提交审核" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (3 != self.i) {
        [self.contentView addSubview:self.tableView];
        
        [self.button removeFromSuperview];
    } else {
        [self.contentView addSubview:self.button];
        [self.tableView removeFromSuperview];
    }
    self.tableView.frame = CGRectMake(0, 0, CWidth, CHeight);
    self.button.frame = CGRectMake(CWidth * 0.2, 0, CWidth * 0.6, CHeight);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == self.i) {
        return CHeight / self.arrayForRun.count;
    } else if (1 == self.i) {
        return CHeight / self.arrayForHome.count;
    } else {
        return CHeight / self.arrayForCar.count;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.switchCell = !self.switchCell;
    SkillDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    cell.i = self.i;
    NSLog(@"????%ld",cell.i);
    cell.j = indexPath.row;
    if ([cell.selectImageView.image isEqual:[UIImage imageNamed:@"circle-圆圈.png"]]) {
        cell.selectImageView.image = [UIImage imageNamed:@"圆.png"];
        self.blockCancel(cell);
    } else {
        
       cell.selectImageView.image = [UIImage imageNamed:@"circle-圆圈.png"];
        self.block(cell);
    }

    

}
- (void)button:(UIButton *)button {
    self.touchBlock(button);
}

@end
