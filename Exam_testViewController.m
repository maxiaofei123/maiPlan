//
//  Exam_testViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-22.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "Exam_testViewController.h"
#import "M_homeViewController.h"
#import "Exam_resultViewController.h"

@interface Exam_testViewController ()
{
    NSArray * labarArr;
    
    UIButton * selectBt1;
    UIButton * selectBt2;
    UIButton * selectBt3;
    int selectTag;
    
    UILabel * timeLbale;
    int timeDate;
}

@end

@implementation Exam_testViewController
@synthesize resultView,returnTag;

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

    labarArr = [[NSArray alloc]initWithObjects:@"上一题",@"未做",@"考试倒计时",@"交卷",@"下一题", nil ];
 
    [self drawNav];
    [self drawView];
    [self drawTabar];
    [self hideTabBar];//隐藏tabbar
    
    //实现倒计时
    timeDate =30*60;
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [self updateTime];

    
}

-(void)drawView
{
    UIImageView * topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 40)];
    topView.image = [UIImage imageNamed:@"test_lan.png"];
    [self.view addSubview:topView];
//---------lable---
    UILabel *userNO = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 80,  20)];
    userNO.text = @"学生序号:";
    userNO.textColor = [UIColor whiteColor];
    userNO.font = [UIFont systemFontOfSize:16];
    [topView addSubview:userNO];
    
    UILabel *userLable = [[UILabel alloc] initWithFrame:CGRectMake(170, 9, 80,  20)];
    userLable.text = @"学生姓名:";
    userLable.textColor = [UIColor whiteColor];
    userLable.font = [UIFont systemFontOfSize:16];

    [topView addSubview:userLable];
    
//---------考试题目---------
    UILabel *testLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 110, 280, 80)];
    [self.view addSubview:testLable];
    

    selectBt1 = [[UIButton alloc] initWithFrame:CGRectMake(40, 200, 30, 30)];
    [selectBt1 setImage:[UIImage imageNamed:@"test_Bt.png"] forState:UIControlStateNormal];
    [selectBt1 setImage:[UIImage imageNamed:@"test_Bt1.png"] forState:UIControlStateSelected];
    selectBt1.tag =3;
    [selectBt1 addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBt1];
    
    selectBt2 = [[UIButton alloc] initWithFrame:CGRectMake(40, 230, 30, 30)];
    [selectBt2 setImage:[UIImage imageNamed:@"test_Bt.png"] forState:UIControlStateNormal];
    [selectBt2 setImage:[UIImage imageNamed:@"test_Bt1.png"] forState:UIControlStateSelected];
    selectBt2.tag =4;
    [selectBt2 addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBt2];
    
    selectBt3 = [[UIButton alloc] initWithFrame:CGRectMake(40, 260, 30, 30)];
    [selectBt3 setImage:[UIImage imageNamed:@"test_Bt.png"] forState:UIControlStateNormal];
    [selectBt3 setImage:[UIImage imageNamed:@"test_Bt1.png"] forState:UIControlStateSelected];
    selectBt3.tag =5;
    [selectBt3 addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBt3];
    
    for (int i=0; i<3; i++) {
        
        UILabel *lableName = [[UILabel alloc] initWithFrame:CGRectMake(70, 200+i*30, 200, 15)];
        lableName.textColor = [UIColor whiteColor];
        [self.view addSubview:lableName];
    }
    
}
 -(void)drawTabar
{
    //--------tabbar按钮--------
    
    static UIView *view;
    view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64, self.view.frame.size.width, 64)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [self.view addSubview:view];
    
    UIButton *Lbutton = [[UIButton alloc] initWithFrame:CGRectMake(10, 7, 35, 30)];
    [Lbutton setImage:[UIImage imageNamed:@"test_left.png"] forState:UIControlStateNormal];
    Lbutton.tag = 6;
    [Lbutton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Lbutton];
    
    UIButton *Tbt = [[UIButton alloc] initWithFrame:CGRectMake(75, 7, 35, 30)];
    [Tbt setImage:[UIImage imageNamed:@"test_weizuo.png"] forState:UIControlStateNormal];
    Tbt.tag = 7;
    [Tbt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Tbt];
    //------commit
    UIButton *commitBt = [[UIButton alloc] initWithFrame:CGRectMake(210, 7, 35, 30)];
    [commitBt setImage:[UIImage imageNamed:@"test_commit.png"] forState:UIControlStateNormal];
    commitBt.tag = 8;
    [commitBt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:commitBt];
    
    UIButton *Rbutton = [[UIButton alloc] initWithFrame:CGRectMake(275, 7, 35, 30)];
    [Rbutton setImage:[UIImage imageNamed:@"test_next.png"] forState:UIControlStateNormal];
    Rbutton.tag = 9;
    [Rbutton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Rbutton];
    
    //----tabarlable
    UILabel *lableName1 = [[UILabel alloc] initWithFrame:CGRectMake(5  ,40, 50, 15)];
    lableName1.text = [labarArr objectAtIndex:0];
    lableName1.textColor = [UIColor whiteColor];
    lableName1.font = [UIFont systemFontOfSize:14];
    [view addSubview:lableName1];
    
    UILabel *lableName2 = [[UILabel alloc] initWithFrame:CGRectMake(75  ,40, 40, 15)];
    lableName2.text = [labarArr objectAtIndex:1];
    lableName2.textColor = [UIColor whiteColor];
    lableName2.font = [UIFont systemFontOfSize:14];
    [view addSubview:lableName2];
    
    UILabel *lableName3 = [[UILabel alloc] initWithFrame:CGRectMake(120  ,40, 100, 15)];
    lableName3.text = [labarArr objectAtIndex:2];
    lableName3.textColor = [UIColor whiteColor];
    lableName3.font = [UIFont systemFontOfSize:14];
    [view addSubview:lableName3];
    
    UILabel *lableName4 = [[UILabel alloc] initWithFrame:CGRectMake(210  ,40, 40, 15)];
    lableName4.text = [labarArr objectAtIndex:3];
    lableName4.textColor = [UIColor whiteColor];
    lableName4.font = [UIFont systemFontOfSize:14];
    [view addSubview:lableName4];
    
    UILabel *lableName5 = [[UILabel alloc] initWithFrame:CGRectMake(265  ,40, 50, 15)];
    lableName5.text = [labarArr objectAtIndex:4];
    lableName5.textColor = [UIColor whiteColor];
    lableName5.font = [UIFont systemFontOfSize:14];
    [view addSubview:lableName5];
    
    //显示时间
    timeLbale = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, 80, 20)];
    timeLbale.text = @"00:00";
    timeLbale.textColor = [UIColor whiteColor];
    [view addSubview:timeLbale];
    
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
    title.text = @"利用飞行器理论考试";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
    UIButton *lButton =[[UIButton alloc] init];
    lButton =[UIButton buttonWithType:0];
    [lButton setImage:[UIImage imageNamed:@"public_home.png"] forState:UIControlStateNormal];
    [lButton setFrame:CGRectMake(5, 7, 30, 30)];
    lButton.tag = 1;
    [lButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lButton];
    
    UIButton *rButton =[[UIButton alloc] init];
    rButton =[UIButton buttonWithType:0];
    [rButton setImage:[UIImage imageNamed:@"topR.png"] forState:UIControlStateNormal];
    [rButton setFrame:CGRectMake(275, 7, 30, 30)];
    rButton.tag = 2;
    [rButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rButton];
    
}
-(void)choose:(UIButton *)sender
{
    switch (sender.tag) {
 
        case 1:
            [self showTabBar];
            [self.navigationController popViewControllerAnimated:NO];
            
            break;
        case 2:
            
            break;
        case 3:
            selectBt1.selected = YES;
            selectBt2.selected = NO;
            selectBt3.selected = NO;
            selectTag =1;
            
            break;
        case 4:
            selectBt1.selected = NO;
            selectBt2.selected = YES;
            selectBt3.selected = NO;
            selectTag =2;
            break;
        case 5:
            selectBt1.selected = NO;
            selectBt2.selected = NO;
            selectBt3.selected = YES;
            selectTag =3;
            break;
        case 6:
            
            break;
        case 7:
            
            break;
        case 8:
      
            resultView =[[Exam_resultViewController alloc] init];
            resultView.hidesBottomBarWhenPushed = NO;
            [self.navigationController pushViewController:resultView animated:NO];
            
            break;
        case 9:
            
            break;
            
        default:
            break;
    }
    
    
}
//隐藏tabbar
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}

//显示tabbar
- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}

-(void)updateTime
{
    timeDate = timeDate - 1 > 0 ? timeDate - 1 : 0;
    timeLbale.text = [self getTime];
}

-(NSString*)getTime {
    
    int imin = (int)(timeDate / 60);
    int isec = (int)(timeDate % 60);
    
    NSString *min = [NSString stringWithFormat:@"%@%d", imin < 10 ? @"0" : @"", imin];
    NSString *sec = [NSString stringWithFormat:@"%@%d", isec < 10 ? @"0" : @"", isec];
    
    NSString *addTime = [NSString stringWithFormat:@"%@:%@", min, sec];
    
    return addTime;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   }


@end
