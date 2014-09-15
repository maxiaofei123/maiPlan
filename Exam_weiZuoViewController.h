//
//  Exam_weiZuoViewController.h
//  Mfeiji
//
//  Created by susu on 14-9-12.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "viewDelegate.h"


@interface Exam_weiZuoViewController : UIViewController
{
//    NSObject<viewDelegate> *delegate;
}


@property(nonatomic,assign)NSObject<viewDelegate> *delegate;

@property (strong,nonatomic)NSArray * weidaArry;



@end


