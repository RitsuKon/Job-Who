//
//  BuyTableViewCell.m
//  Job-Who
//
//  Created by 金洪生 on 16/6/8.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "BuyTableViewCell.h"

@interface BuyTableViewCell()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *addressLabel;

@property (assign, nonatomic) NSInteger i;
@property (assign, nonatomic) NSInteger touch;
@end

@implementation BuyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.i = 0;
        self.touch = 0;
        [self createImageView];
        [self createLabel];
        [self createTableView];
    }
    return self;
}
- (void)createImageView {
    self.iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"定位灰.png"]];
    [self.contentView addSubview:self.iconImageView];

}
- (void)createLabel {
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = [UIFont systemFontOfSize:12];
    self.addressLabel.text = @"购买地址";
    [self.contentView addSubview:self.addressLabel];
}
- (void)createTableView {
    self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:0];
    self.selectTableView.delegate = self;
    self.selectTableView.dataSource = self;
    self.selectTableView.scrollEnabled = NO;
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.selectTableView setTableFooterView:v];
    [self.selectTableView registerClass:[AddressSelectTableViewCell class] forCellReuseIdentifier:@"addressSelect"];
    [self.contentView addSubview:self.selectTableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == self.addressTag) {
        return 2;
    } else {
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressSelectTableViewCell *cellAddress = [tableView dequeueReusableCellWithIdentifier:@"addressSelect"];
    if (2 == indexPath.row) {
        cellAddress.i = 1;
        NSLog(@"看看这边传过来没有%@",self.address);
        cellAddress.selectLabel.text = self.address;
    } else {
        cellAddress.i = 0;
        if (0 == indexPath.row) {
            cellAddress.label.text = @"不限";
            if (0 == self.touch) {
                cellAddress.correctImageView.image = [UIImage imageNamed:@"circle-圆圈.png"];
            } else {
                cellAddress.correctImageView.image = [UIImage imageNamed:@"圆.png"];
            }
        } else {
            cellAddress.label.text = @"指定地址";
//            if (0 == self.addressTag) {
//                self.selectTableView.separatorStyle = 0;
//            } else {
//                self.selectTableView.separatorStyle = 1;
//            }
            
            if (0 == self.touch) {
                
                cellAddress.correctImageView.image = [UIImage imageNamed:@"圆.png"];
            } else {
                cellAddress.correctImageView.image = [UIImage imageNamed:@"circle-圆圈.png"];
            }
        }

    }
    
    return cellAddress;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.row) {
        self.touch = 0;
        self.addressTag = 0;
        NSString *str = @"请选择购买地址";
        self.noSelect(str);
        [self.selectTableView reloadData];
    } else if (1 == indexPath.row) {
        self.touch = 1;
        self.addressTag = 1;
        NSString *str = @"";
        self.noSelect(str);
        [self.selectTableView reloadData];
    } else {
        self.info(tableView);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == self.addressTag) {
        return CHeight * 0.5;
    }
    else {
        if (2 == indexPath.row) {

            if ([self.address isEqualToString:@"请选择购买地址"] || self.address == NULL) {
                return CHeight / 3;
            } else {
              return [AddressSelectTableViewCell heightForCell:self.address] + 10;
            }
            
        } else {
            if ([self.address isEqualToString:@"请选择购买地址"] || self.address == NULL) {
                return CHeight / 3;
            } else {
                return Height * 0.07;
            }
        }
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake(CWidth * 0.05, CHeight / 2 - 8, 16, 16);
    self.addressLabel.frame = CGRectMake(CWidth * 0.05 + 21, CHeight / 2 - 10, CWidth * 0.2, 20);
    self.selectTableView.frame = CGRectMake(CWidth * 0.25 + 26, CHeight * 0.05, CWidth - 26 - CWidth * 0.3, CHeight * 0.9);
}

@end
