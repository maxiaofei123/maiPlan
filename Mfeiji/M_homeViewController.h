//
//  M_homeViewController.h
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class home_xuzhiViewController;


@interface M_homeViewController : UIViewController<UIActionSheetDelegate>
{
    NSMutableArray * itemArray;

}


@property (nonatomic ,strong) home_xuzhiViewController * xuzhiView;


@end
