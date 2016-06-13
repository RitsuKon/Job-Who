//
//  AddressTableViewCell.h
//  Job-Who
//
//  Created by 金洪生 on 16/5/27.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BMKPoiInfo;
typedef void(^buttonClick)(UIButton *button);
typedef void(^Address)(BMKPoiInfo *poiInfo);

@interface AddressTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *address;
@property (strong, nonatomic) BMKPoiInfo *poiInfo;
@property (strong, nonatomic) UIImageView *selectedImage;
@property (copy, nonatomic) buttonClick block;
@property (copy, nonatomic) Address blockInfo;
@end
