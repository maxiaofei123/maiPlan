//
//  AppDelegate.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "AppDelegate.h"
#import "M_examViewController.h"
#import "M_selfViewController.h"
#import "M_messageViewController.h"
#import "M_setViewController.h"

@implementation AppDelegate
@synthesize homeView , examView ,selfView , messageView ,setView ;
@synthesize tabBar,intoBt;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [NSThread sleepForTimeInterval:2.0];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    if (Version >= 7.0) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, self.window.frame.size.height-20)];
    view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"start2.png"]];
    [self.window addSubview:view];

    
    intoBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];;
    intoBt.frame = CGRectMake(105, self.window.frame.size.height-110, 125, 25);
    intoBt.backgroundColor=[UIColor colorWithRed:41./255 green:49./255 blue:104./255 alpha:1.];
    [intoBt.layer setCornerRadius:8.0];
    [intoBt setTitle:@"进入体验" forState:UIControlStateNormal];
    [intoBt setTitle:@"进入体验" forState:UIControlStateSelected];
    intoBt.titleLabel.font = [UIFont systemFontOfSize:14];
    intoBt.titleLabel.textColor =[UIColor whiteColor];
    [intoBt addTarget:self action:@selector(intoNext:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:intoBt];
    
     [[UIApplication sharedApplication] setStatusBarHidden:NO];

    
    [self.window makeKeyAndVisible];
    [WXApi registerApp:@"wxe3e595aa048f61e5"];
    
    return YES;
}
-(void)intoNext:(UIButton *)sender
{
    [intoBt removeFromSuperview];
    self.window.backgroundColor = [UIColor whiteColor];
    
    examView = [[M_examViewController alloc] init];
    _exam_Nav = [[UINavigationController alloc] initWithRootViewController:examView];
    
    selfView = [[M_selfViewController alloc] init];
    _self_Nav = [[UINavigationController alloc] initWithRootViewController:selfView];
    
    messageView = [[M_messageViewController alloc] init];
    _message_Nav = [[UINavigationController alloc] initWithRootViewController:messageView];
    
    setView = [[M_setViewController alloc] init];
    _set_Nav = [[UINavigationController alloc] initWithRootViewController:setView];
    
    
    //tabbar
    tabBar = [[UITabBarController alloc] init];
    tabBar.viewControllers = [NSArray  arrayWithObjects:_exam_Nav,_self_Nav,_message_Nav,_set_Nav, nil];
    
    _home_Nav.tabBarItem.title = @"首页";
    _home_Nav.tabBarItem.image = [UIImage imageNamed:@"home.png"];
    
    _exam_Nav.tabBarItem.title = @"考试";
    _exam_Nav.tabBarItem.image = [UIImage imageNamed:@"home.png"];
    
    _self_Nav.tabBarItem.title = @"我的";
    _self_Nav.tabBarItem.image = [UIImage imageNamed:@"my.png"];
    
    _message_Nav.tabBarItem.title = @"航校";
    _message_Nav.tabBarItem.image = [UIImage imageNamed: @"hangxiao.png"];
    
    _set_Nav.tabBarItem.title = @"设置";
    _set_Nav.tabBarItem.image = [UIImage imageNamed:@"set.png"];
    
    
    tabBar.tabBar.tintColor = [UIColor whiteColor];
    

    CGRect frame = CGRectMake(0, 0, 320, 49);
    UIView * v = [[UIView alloc] initWithFrame:frame];
    UIColor * color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    v.backgroundColor = color;
    [tabBar.tabBar insertSubview:v atIndex:0];
    self.window.rootViewController = tabBar;


}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
