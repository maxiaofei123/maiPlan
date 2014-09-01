//
//  publicRequest.h
//  Mfeiji
//
//  Created by susu on 14-8-26.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface publicRequest : NSObject
+(UIImage *)imageWithColor:(UIColor *)color;
//获取题目
+(NSArray *)getQuestion: (NSString *)token;

@end
