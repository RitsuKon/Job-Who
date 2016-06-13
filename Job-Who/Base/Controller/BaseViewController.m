//
//  BaseViewController.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/26.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Color_System,UITextAttributeTextColor, nil]];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view.
}

#pragma mark - 手机号判断
- (NSInteger )valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return 1;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return 0;
        }else{
            return 2;
        }
    }
    return 0;
}

#pragma mark - 弹出框
- (void)alert:(NSInteger )i withTextField:(UITextField *)textField{
    UIAlertController *alertNumber = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机只能为11位数字" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertController *alertError = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [textField becomeFirstResponder];
    }];
    if (1 == i) {
        [alertNumber addAction:action];
        [self presentViewController:alertNumber animated:YES completion:^{
            
        }];
    } else {
        [alertError addAction:action];
        [self presentViewController:alertError animated:YES completion:nil];
    }
    
}

#pragma mark - 修改navigationBar
- (void)changeNavigationBar{
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
}

#pragma mark - 下划线
- (void)underlineForTextWithButton:(UIButton *)button withText:(NSString *)text {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [button setAttributedTitle:str forState:UIControlStateNormal];
}
#pragma mark - 自定义navi
- (void)createNaviWithType:(NSInteger )i withViewController:(UIViewController *)vc{
    self.naviView = [[NaView alloc] initWithFrame:CGRectMake(0, 0, Width, 64) withType:i];
    [self.view addSubview:self.naviView];
    self.naviView.block = ^(UIButton *button) {
        [vc.navigationController popViewControllerAnimated:YES];
    };
}
#pragma mark - 获取系统时间
- (NSString *)getDateFromSystem {
    NSDate *date=[NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *dateString =[dateformatter stringFromDate:date];

    return dateString;
}
#pragma mark - 计算两点距离
- (double)distanceBetweenLtaBegin:(double )lta1 withLonBegin:(double)lon1 withLtaEnd:(double)lta2 withLonEnd:(double)lon2 {
    CLLocationCoordinate2D pointBegin = CLLocationCoordinate2DMake(lta1, lon1);
    CLLocationCoordinate2D pointEnd = CLLocationCoordinate2DMake(lta2, lon2);
    BMKMapPoint point1 = BMKMapPointForCoordinate(pointBegin);
    BMKMapPoint point2 = BMKMapPointForCoordinate(pointEnd);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    return distance;
}
#pragma mark - 字体设置颜色
- (NSMutableAttributedString *)attributeString:(NSString *)str withLocation:(NSInteger )location withLength:(NSInteger )length {
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str attributes:nil];
    [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(location, length)];
    return attributeString;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
