//
//  publicRequest.m
//  Mfeiji
//
//  Created by susu on 14-8-26.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "publicRequest.h"

@implementation publicRequest

+(UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect =CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

+(NSArray *)getQuestion: (NSString *)token
{
    NSArray *returnArr =[[NSArray alloc] init];
    NSString *str = [NSString stringWithFormat:@"%@",@"http://42.120.9.87:4010/api/exams/question_group"];
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSURLResponse *response =nil;
    NSError * error =nil;
    NSData *data =[NSURLConnection sendSynchronousRequest:requestUrl returningResponse:&response error:&error];
    
    if (error) {
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前网络不可用,请稍后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return nil;
        
    }
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSLog(@"get requeset%@",dic);
    
    returnArr = [dic objectForKey:@"question_group"];
//    NSLog(@"%@",returnArr);
    return returnArr;


}

@end
