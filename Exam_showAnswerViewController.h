//
//  Exam_showAnswerViewController.h
//  Mfeiji
//
//  Created by susu on 14-9-11.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Exam_showAnswerViewController : UIViewController

@property(strong ,nonatomic)NSDictionary * showDic;
@property (strong ,nonatomic)NSDictionary *ztDic;
@property(nonatomic)int textId;

-(void)setQuestion:(int)number;

@end
