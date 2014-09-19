//
//  AppDelegate.h
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class M_homeViewController,M_examViewController,M_selfViewController,M_messageViewController,M_setViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong ,nonatomic) M_homeViewController *homeView;
@property (strong ,nonatomic) M_examViewController * examView;
@property (strong ,nonatomic) M_selfViewController * selfView;
@property (strong ,nonatomic) M_messageViewController *messageView;
@property (strong ,nonatomic) M_setViewController * setView;

@property (strong,nonatomic)  UINavigationController *home_Nav;
@property (strong,nonatomic)  UINavigationController *exam_Nav;
@property (strong,nonatomic)  UINavigationController *self_Nav;
@property (strong,nonatomic)  UINavigationController *message_Nav;
@property (strong,nonatomic)  UINavigationController *set_Nav;

@property (strong ,nonatomic)UITabBarController *tabBar;

@property (strong ,nonatomic) UIImageView * starImage;
@property (strong ,nonatomic) UIButton * intoBt;





@end
