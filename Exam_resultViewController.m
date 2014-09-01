//
//  Exam_resultViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-22.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "Exam_resultViewController.h"
#import "M_examViewController.h"
#import "Exam_testViewController.h"

@interface Exam_resultViewController ()
{
    NSArray *lableArr;
    UINavigationBar * nav;
}
@end

@implementation Exam_resultViewController

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
    
    self.view.backgroundColor = [UIColor blackColor];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-20)];
    view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"hui_bg.png"]];
    [self.view addSubview:view];
    
    lableArr = [[NSArray alloc] initWithObjects:@"成绩:",@"用时:",@"航校:", nil];
    [self drawNav];
    [self drawTabar];
    [self drawView];
}

-(void)drawView
{
    for (int i =0 ; i<3; i++) {
        UILabel * Lable =[[UILabel alloc] initWithFrame:CGRectMake(50, 220+i*30, 50, 20)];
        Lable.text = [lableArr objectAtIndex:i];
        [self.view addSubview:Lable];
    }
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
    title.text = @"考试结果";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
    
    UIButton *lButton =[[UIButton alloc] init];
    lButton =[UIButton buttonWithType:0];
    [lButton setImage:[UIImage imageNamed:@"result_tuichu.png"] forState:UIControlStateNormal];
    [lButton setFrame:CGRectMake(10, 6, 30, 30)];
    lButton.tag = 1;
    [lButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lButton];
    //  推出考试lable
    UILabel *exitLable = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 60, 20)];
    exitLable.textColor = [UIColor whiteColor];
    exitLable.text = @"退出考试";
    exitLable.font = [UIFont systemFontOfSize:14];
    [view addSubview:exitLable];
    
    UIButton *rButton =[[UIButton alloc] init];
    rButton =[UIButton buttonWithType:0];
    [rButton setImage:[UIImage imageNamed:@"topR.png"] forState:UIControlStateNormal];
    [rButton setFrame:CGRectMake(275, 6, 30, 30)];
    rButton.tag = 2;
    [rButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rButton];
    
}


-(void)drawTabar
{
    static UIView *view;
    view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [self.view addSubview:view];
    
    
    UIButton *Lbutton = [[UIButton alloc] initWithFrame:CGRectMake(25, 7, 35, 30)];
    [Lbutton setImage:[UIImage imageNamed:@"result_chakan.png"] forState:UIControlStateNormal];
    Lbutton.tag = 3;
    [view addSubview:Lbutton];
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 80, 20)];
    lable1.text =@"查看答案";
    lable1.font = [UIFont systemFontOfSize:16];
    lable1.textColor = [UIColor whiteColor];
    [view addSubview:lable1];
    
    
    UIButton *Rbutton = [[UIButton alloc] initWithFrame:CGRectMake(267, 7, 35, 30)];
    [Rbutton setImage:[UIImage imageNamed:@"result_paihang.png"] forState:UIControlStateNormal];
    Rbutton.tag = 4;
    [view addSubview:Rbutton];
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(260, 40, 80, 20)];
    lable2.text =@"排行榜";
    lable2.font =[UIFont systemFontOfSize:16];
    lable2.textColor = [UIColor whiteColor];
    [view addSubview:lable2];
    
    

}

-(void)choose:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            self.hidesBottomBarWhenPushed = NO;
            _examView = [[M_examViewController alloc] init];
            [self.navigationController pushViewController:_examView animated:NO];
            
          //  [self.navigationController popViewControllerAnimated:NO];
            
        }
            break;
            
        case 2:
        
            
            break;
        case 3:
            
            break;
        case 4:
            
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
