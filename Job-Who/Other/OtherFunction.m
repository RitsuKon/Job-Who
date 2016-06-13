//
//  OtherFunction.m
//  Job-Who
//
//  Created by 金洪生 on 16/5/26.
//  Copyright © 2016年 金洪生. All rights reserved.
//

#import "OtherFunction.h"

@implementation OtherFunction
#pragma mark - plist文件解析
- (NSDictionary *)analysisPlistWithName:(NSString *)str withType:(NSString *)type {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:str ofType:type];
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return dictionary;
}

@end
