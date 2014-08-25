//
//  home_xuzhiViewController.h
//  Mfeiji
//
//  Created by susu on 14-7-22.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class M_homeViewController;

@interface home_xuzhiViewController : UIViewController<UITextViewDelegate>

@property (strong,nonatomic) M_homeViewController * homeView;
@property (strong ,nonatomic)NSString *titleStr;
@end
