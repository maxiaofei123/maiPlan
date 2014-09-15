//
//  Exam_testViewController.h
//  Mfeiji
//
//  Created by susu on 14-7-22.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exam_weiZuoViewController.h"
#import "viewDelegate.h"

@class M_homeViewController;
@class Exam_resultViewController;

@interface Exam_testViewController : UIViewController<viewDelegate>


@property (strong , nonatomic)  M_homeViewController *home;
@property (strong ,nonatomic)Exam_resultViewController *resultView;
@property (atomic,assign )int returnTag;
@property (nonatomic)int textId;

@end

