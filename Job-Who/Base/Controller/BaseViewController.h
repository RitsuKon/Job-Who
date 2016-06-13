//
//  BaseViewController.h
//  Job-Who
//
//  Created by 金洪生 on 16/5/26.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NaView;
@interface BaseViewController : UIViewController
@property (strong, nonatomic) NaView *naviView;

- (NSInteger )valiMobile:(NSString *)mobile;
- (void)alert:(NSInteger )i withTextField:(UITextField *)textField;
- (void)changeNavigationBar;
- (void)underlineForTextWithButton:(UIButton *)button withText:(NSString *)text;
- (void)createNaviWithType:(NSInteger )i withViewController:(UIViewController *)vc;
- (NSString *)getDateFromSystem;
- (double)distanceBetweenLtaBegin:(double )lta1 withLonBegin:(double)lon1 withLtaEnd:(double)lta2 withLonEnd:(double)lon2;
- (NSMutableAttributedString *)attributeString:(NSString *)str withLocation:(NSInteger )location withLength:(NSInteger )length;
@end
