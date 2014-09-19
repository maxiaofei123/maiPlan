//
//  M_setViewController.h
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SBJson.h"

@interface M_setViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, NSURLConnectionDelegate>
@property (strong,nonatomic)UITableView * setTableView;

@end
