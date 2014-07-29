//
//  M_messageViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_messageViewController.h"

@interface M_messageViewController ()
{
    UITextView * textView;
    NSString * liuyanStr;
}
@end

@implementation M_messageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-20)];
    view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"hui_bg.png"]];
    [self.view addSubview:view];
    [self drawNav];
    [self drawView];
    
    
  
}

- (void)drawNav
{
    UIView *view;

    view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
  
    [self.view addSubview:view];
    
    
    UILabel *title;
    title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, view.frame.size.width-120, 44)];
    
    title.backgroundColor = [UIColor clearColor];
    title.text = @"我的个人主页";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
}

-(void)drawView
{
    UIImageView * view = [[UIImageView alloc] initWithFrame:CGRectMake(30, 135, 135, 20)];
    view.image = [UIImage imageNamed:@"liuyan_jianyi.png"];
    [self.view addSubview:view];
    
    UIImageView * liuyan = [[UIImageView alloc] initWithFrame:CGRectMake(30, 160, 263, 120)];
    liuyan.image = [UIImage imageNamed:@"liuyanban.png"];
    [liuyan setUserInteractionEnabled:YES];
    [self.view addSubview:liuyan];
    
   //textfield
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 3, 253, 114)];
    textView.font = [UIFont systemFontOfSize:14];
    textView.delegate =self;
    textView.textColor = [UIColor blackColor];
    [liuyan addSubview:textView];
    
    
    
    UIButton * Bt= [[UIButton alloc] init];
    Bt = [UIButton buttonWithType:0];
    Bt.frame = CGRectMake(200, 300, 90, 30);
    [Bt setImage:[UIImage imageNamed:@"liuyan_tijiao.png" ]forState:UIControlStateNormal];
    [Bt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:Bt];
  
    
}

-(void)choose:(UIButton *)sender
{
    liuyanStr = [[NSString alloc] init];
    liuyanStr = textView.text;
    NSLog(@"liuyan = %@",liuyanStr);
    

}
-(void)submitWords:(NSString *)str
{
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{   NSLog(@"yincang");
    //隐藏键盘
    [textView resignFirstResponder];
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
