//
//  Exam_testViewController.h
//  Mfeiji
//
//  Created by susu on 14-7-22.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class M_homeViewController;
@class Exam_resultViewController;

@interface Exam_testViewController : UIViewController


@property (strong , nonatomic)  M_homeViewController *home;
@property (strong ,nonatomic)Exam_resultViewController *resultView;
@property (atomic,assign )int returnTag;

-(void)setQuestion:(int)number;


@end
