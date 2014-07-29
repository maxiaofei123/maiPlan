//
//  home_xuzhiViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-22.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "home_xuzhiViewController.h"
#import "M_homeViewController.h"

@interface home_xuzhiViewController ()
{
    UITextView * textView;
}

@end

@implementation home_xuzhiViewController
@synthesize titleStr;
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
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 70, 310, self.view.frame.size.height-130)];
    [self.view addSubview:textView];
    
}




- (void)drawNav
{
    static UIView *view;
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    
    [self.view addSubview:view];
    
    
    UILabel *title;
    title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, view.frame.size.width-120, 44)];
    
    title.backgroundColor = [UIColor clearColor];
    title.text = titleStr;
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
    UIButton *lButton =[[UIButton alloc] init];
    lButton =[UIButton buttonWithType:0];
    [lButton setImage:[UIImage imageNamed:@"home_back.png"] forState:UIControlStateNormal];
    [lButton setFrame:CGRectMake(5, 5, 30, 30)];
    lButton.tag = 1;
    [lButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lButton];
    
    UIButton *rButton =[[UIButton alloc] init];
    rButton =[UIButton buttonWithType:0];
    [rButton setImage:[UIImage imageNamed:@"topR.png"] forState:UIControlStateNormal];
    [rButton setFrame:CGRectMake(275, 5, 30, 30)];
    rButton.tag = 2;
    [rButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rButton];
    
}

-(void)choose:(UIButton *)sender
{

    switch (sender.tag) {
        case 1:
            
            [self.navigationController popViewControllerAnimated:NO ];
            
            break;
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end
