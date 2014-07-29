//
//  M_homeViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_homeViewController.h"
#import "home_xuzhiViewController.h"

@interface M_homeViewController ()

@end

@implementation M_homeViewController


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
    
    UIButton *rButton =[[UIButton alloc] init];
    rButton =[UIButton buttonWithType:0];
    [rButton setImage:[UIImage imageNamed:@"topR.png"] forState:UIControlStateNormal];

    [rButton setFrame:CGRectMake(260, 0, 44, 44)];
    rButton.tag = 5;
    [rButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rButton];
    
    UILabel *title;
    title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, view.frame.size.width-120, 44)];    
    title.backgroundColor = [UIColor clearColor];
    title.text = @"麦飞机";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
}

-(void)drawView
{
    UIImageView * topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 62, 320, 87)];
    topImage.image = [UIImage imageNamed:@"home_plan.png"];
    [self.view addSubview:topImage];
    
    for (int i =0; i<4; i++) {
        UIImageView * XXX = [[UIImageView alloc] initWithFrame:CGRectMake(10, 175 + i*76, 300, 70)];
        XXX.image = [UIImage imageNamed:[NSString stringWithFormat:@"home_lan%d.png",i+1]];
        [XXX setUserInteractionEnabled:YES];
        [self.view addSubview:XXX];

    }
    for (int i =0 ; i<4; i++) {
        
        UIButton * Bt= [[UIButton alloc] init];
        Bt = [UIButton buttonWithType:0];
        Bt.frame = CGRectMake(120, 200+i*76, 90, 22);
        [Bt setImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_%d.png",i] ]forState:UIControlStateNormal];
        [Bt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        Bt.tag=i;
        [self.view addSubview:Bt];
       
    }
    
}


-(void)choose:(UIButton *)sender
{
    
    if (sender.tag == 0) {
//        学飞机
        _xuzhiView = [[home_xuzhiViewController alloc] init];
        _xuzhiView.titleStr =@"学飞机须知";
        [self.navigationController pushViewController:_xuzhiView animated:NO];
        
        
    }else if(sender.tag == 1){
//        买飞机
        _xuzhiView = [[home_xuzhiViewController alloc] init];
        _xuzhiView.titleStr =@"买飞机须知";
        [self.navigationController pushViewController:_xuzhiView animated:NO];
        
    
    }else if(sender.tag == 2){
//        租飞机
        _xuzhiView = [[home_xuzhiViewController alloc] init];
        _xuzhiView.titleStr =@"租飞机须知";
        [self.navigationController pushViewController:_xuzhiView animated:NO];
        
    }else if(sender.tag == 3){
        
//        玩飞机
        _xuzhiView = [[home_xuzhiViewController alloc] init];
        _xuzhiView.titleStr =@"玩飞机须知";
        [self.navigationController pushViewController:_xuzhiView animated:NO];
    }
    else
    {
//        NSLog(@"home_else");
    
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
