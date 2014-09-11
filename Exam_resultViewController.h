//
//  Exam_resultViewController.h
//  Mfeiji
//
//  Created by susu on 14-7-22.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class M_examViewController;

@interface Exam_resultViewController : UIViewController

@property (strong ,nonatomic) M_examViewController *examView;
@property (nonatomic) int useTime;
@property (nonatomic) int useSec;
@property (nonatomic) float  resultScore;
@property (strong ,nonatomic)NSDictionary *checkDic;
@property (strong,nonatomic)NSDictionary *zhuangtai;
@end
