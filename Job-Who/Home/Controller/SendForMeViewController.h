//
//  SendForMeViewController.h
//  Job-Who
//
//  Created by 金洪生 on 16/6/1.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendForMeViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate ,UITextFieldDelegate>
@property (strong, nonatomic) NSString *addressStr;
@property (strong, nonatomic) NSString *addressDetail;
@property (strong, nonatomic) NSString *addressReceive;
@property (assign, nonatomic) NSInteger tagAddress;
@property (assign, nonatomic) double lta;
@property (assign, nonatomic) double lon;
@property (assign, nonatomic) double receiveLta;//取货 收货经纬度
@property (assign, nonatomic) double getLta;
@property (assign, nonatomic) double receiveLon;
@property (assign, nonatomic) double getLon;

@property (strong, nonatomic) UITableView *sendTableView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIView *viewForDate;
@property (strong, nonatomic) NSMutableArray *arrayDay;
@property (strong, nonatomic) NSMutableArray *arrayHourToday;
@property (strong, nonatomic) NSMutableArray *arrayHourTomorrow;
@property (strong, nonatomic) NSMutableArray *arrayMinute;
@property (strong, nonatomic) NSMutableArray *arrayMinuteBefore;
@property (strong, nonatomic) NSMutableArray *arrayMinuteAfter;
@property (assign, nonatomic) NSInteger selectDay;
@property (assign, nonatomic) NSInteger selectHour;
@property (assign, nonatomic) NSInteger selectMinute;
@property (strong, nonatomic) UIButton *buttonSure;
@property (strong, nonatomic) UIButton *buttonCancel;
@property (strong, nonatomic) NSString *strTime;
@property (assign, nonatomic) NSInteger timeTag;//判断时间是默认还是选择
@property (assign, nonatomic) NSInteger goodTag;//判断商品是默认还是选择
@property (strong, nonatomic) NSMutableArray *arrayForType;
@property (assign, nonatomic) NSInteger cellJudge;//判断是哪个cell点击
@property (strong, nonatomic) NSString *strType;//物品类型
@property (assign, nonatomic) CGRect keyboardRect;//键盘高度
@property (assign, nonatomic) NSInteger cancelTag;//判断黄色label的X按钮是否关闭
@property (assign, nonatomic) NSInteger keyboardTag;//判断键盘是否回收

@property (strong, nonatomic) NSString *receiveNumber;//收货人电话
@property (strong, nonatomic) NSString *sendNumber;//发货人电话
@property (assign, nonatomic) NSInteger numberTag;//判断点击收货人电话本还是发货人电话本

@property (assign, nonatomic) NSInteger tagRepeat;//cell重用判断
@property (assign, nonatomic) double instance;//两点距离
@property (assign, nonatomic) double money;//总价
@property (assign, nonatomic) double smallmoney;//小费
@property (assign, nonatomic) double money1;
@property (strong, nonatomic) NSString *strMoney;
@property (assign, nonatomic) CGRect rect;//小费提示面板
@property (strong, nonatomic) NSString *receive;//取货地址详细
@property (strong, nonatomic) NSString *get;//收货地址详细
@property (strong, nonatomic) NSString *receiveTime;//取货时间
@property (strong, nonatomic) NSString *goodType;//物品类型
@property (strong, nonatomic) NSString *goodPrice;//物品价值
@property (strong, nonatomic) NSString *goodInfo;//物品信息
@property (strong, nonatomic) NSString *goodsOther1;//物品附加信息
@property (strong, nonatomic) NSString *goodsOther2;//物品附加信息
- (void)alertWithError:(NSInteger )i;
@end
