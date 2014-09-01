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
    NSArray *textName;
    
    
    NSMutableDictionary *zhuangTaiDic;
    NSMutableArray *buttonArr;
    NSMutableArray *lableArr;
    NSMutableArray *anwserText;

    int selectTag;
    int timeDate;
    int  textId;
    
    UILabel * timeLbale;
    UILabel *testLable;
    UILabel *anwserLable;
   
    UIImageView * view;
    UIImageView *subjectView;
    UIImageView *showImageView;
    UIImageView *setQuestionView;
    
    NSTimer * timer;

}

@end

@implementation Exam_testViewController
@synthesize resultView,returnTag;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];

    labarArr = [[NSArray alloc]initWithObjects:@"上一题",@"未做",@"考试倒计时",@"交卷",@"下一题", nil ];
    zhuangTaiDic = [[NSMutableDictionary alloc] init];
    
    
    textId =0;
   
    [self drawNav];
    [self drawView];
    [self drawTabar];
    [self hideTabBar];//隐藏tabbar
    [self requestQuestion];
   

}
-(void)requestQuestion
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://42.120.9.87:4010/api/exams/question_group?auth_token=WZtk4nqj54KJQZsMTepY" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *dic=responseObject;
        textName=dic[@"question_group"];
//        NSLog(@"textname=%@",textName);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"开始做题目了, 准备好了么?"
                                                           delegate:self
                                                  cancelButtonTitle:@"开始"
                                                  otherButtonTitles:nil];
        alertView.tag = 101;
        [alertView show];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}

-(void)setQuestion:(int)number
{
    if (textName.count ==0) {
        
    }else{
        //每个题目下的问题
        anwserText = [[NSMutableArray alloc] init];
        NSArray *arr = [[NSArray alloc] init];
        arr= [[textName objectAtIndex:number] objectForKey:@"options"];
        NSLog(@"arr =%@",arr);
        for (int i=0; i<arr.count; i++) {
            [anwserText addObject:[[arr objectAtIndex:i] objectForKey:@"content"]];
            UILabel *lable=[lableArr objectAtIndex:i];
            lable.text =[anwserText objectAtIndex:i];
            //适应高度
            UIFont *font = [UIFont systemFontOfSize:16.0];
            CGSize size = CGSizeMake(200, 2000);
            CGSize labelsize =[[anwserText objectAtIndex:i] sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];;
            
            lable.frame.size.height>=labelsize.height?labelsize.height:20;
            lable.frame = CGRectMake(lable.frame.origin.x, lable.frame.origin.y, 200, labelsize.height);

        }
        
        NSString * examStr = [[NSString alloc] init];
        examStr = [[textName objectAtIndex:number] objectForKey:@"subject"];
        UIFont *font = [UIFont systemFontOfSize:18.0];
        CGSize size = CGSizeMake(200, 2000);
        CGSize labelsize =[examStr sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];;
   
        testLable.frame.size.height>=labelsize.height?labelsize.height:30;
        testLable.frame =CGRectMake(30, 10, 280, labelsize.height);
        testLable.text = [NSString stringWithFormat:@"%d:  %@",number+1,examStr];
    }

}


-(void)choose:(UIButton *)sender
{
    switch (sender.tag) {
            
        case 1:
            
            [timer invalidate];
            [self showTabBar];
            [self.navigationController popViewControllerAnimated:NO];
            
            break;
        case 2:
            
            break;
        case 6://上一题
        {
            textId = textId ==0 ? 0 :textId -1;
            NSString * valueStr = [[NSString alloc] init];
            valueStr =[zhuangTaiDic objectForKey:[NSString stringWithFormat:@"%d",textId]];
             int tag = [valueStr  intValue];
            if (!(valueStr.length ==0)) {
                for (int i=0; i<3; i++) {
                    UIButton * bt = [buttonArr objectAtIndex:i];
                    if (i==tag) {
                        bt.selected = YES;
                       
                    }else
                    {
                        bt.selected = NO;
                    }
                }
            }else{
                for (int i=0; i<3; i++) {
                    UIButton * bt = [buttonArr objectAtIndex:i];
                    bt.selected =NO;
                }
            }
            [self setQuestion:textId];
        }
    
            break;
        case 7:

            break;
        case 8:
        {
            if (zhuangTaiDic.count <textName.count) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"你还没有做题目哦~"
                                                                   delegate:self
                                                          cancelButtonTitle:@"提交"
                                                          otherButtonTitles:@"继续做题",nil];
                alertView.tag = 9501;
                [alertView show];
            }else{
            
                resultView =[[Exam_resultViewController alloc] init];
                resultView.hidesBottomBarWhenPushed = NO;
                [self.navigationController pushViewController:resultView animated:NO];
            }
        }
            break;
        case 9://下一题
        {
            textId =textId == (textName.count-1) ? (textName.count-1) :textId + 1;
            NSString * valueStr = [[NSString alloc] init];
            
            valueStr =[zhuangTaiDic objectForKey:[NSString stringWithFormat:@"%d",textId]];
            int tag = [valueStr  intValue];
            NSLog(@"ca,,,,,,,,,,,%d",valueStr.length);
            if (!(valueStr.length ==0)) {
                for (int i=0; i<3; i++) {
                    UIButton * bt = [buttonArr objectAtIndex:i];
                    if (i==tag) {
                        bt.selected = YES;
                        
                    }else
                    {
                        bt.selected = NO;
                       
                    }
                }

            }
            else{
                for (int i=0; i<3; i++) {
                    UIButton * bt = [buttonArr objectAtIndex:i];
                    bt.selected =NO;
                }
            }
            
            [self setQuestion:textId];
        
        }

            break;
            
        default:
            break;
    }

    
    //保存 button的选中状态设置
    if (sender.tag >2 && sender.tag<6) {
    
        for (int i=3; i<6; i++) {
            UIButton * bt =[buttonArr objectAtIndex:i-3];

            if (i==sender.tag) {
                bt.selected = YES;
                [zhuangTaiDic setObject:[NSString stringWithFormat:@"%d",i-3] forKey:[NSString stringWithFormat:@"%d",textId]];
            }
            else
            {
                bt.selected = NO;
            }
        }
    }

    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==9501) {
        if (buttonIndex == 0) {
            resultView =[[Exam_resultViewController alloc] init];
            resultView.hidesBottomBarWhenPushed = NO;
            [self.navigationController pushViewController:resultView animated:NO];
        }
    }
    if (alertView.tag ==9502) {//倒计时为0
        if (buttonIndex ==0) {
            resultView =[[Exam_resultViewController alloc] init];
            resultView.hidesBottomBarWhenPushed = NO;
            [self.navigationController pushViewController:resultView animated:NO];

        }else//退出答题
        {   [timer invalidate];
            [self showTabBar];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    
    if (alertView.tag ==101) {
        if (buttonIndex ==0) {
            
            [self setQuestion:0];
            //实现倒计时
            timeDate =10*60;
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        }
    }

}

#pragma mark --绘制页面;
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
    view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, self.view.frame.size.height -100)];
    [view setUserInteractionEnabled:YES];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"hui_bg.png"]];
    [self.view addSubview:view];
    
    
    testLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 280, 30)];
    testLable.lineBreakMode = NSLineBreakByWordWrapping;
    testLable.numberOfLines = 0;
    testLable.font = [UIFont systemFontOfSize:18];
    [view addSubview:testLable];
    
    
    buttonArr =[[NSMutableArray alloc] init];
    lableArr = [[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(40, 100+50*i, 30, 30)];
        [bt setImage:[UIImage imageNamed:@"test_Bt.png"] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"test_Bt1.png"] forState:UIControlStateSelected];
        bt.tag =3+i;
        bt.selected =NO;
        [bt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:bt];
        [buttonArr addObject:bt];
    
        UILabel *lable =[[UILabel alloc] initWithFrame:CGRectMake(80, 106+i*50, 200, 20)];
        lable.textColor = [UIColor blackColor];
        lable.lineBreakMode = NSLineBreakByWordWrapping;
        lable.numberOfLines = 0;
        lable.textAlignment = 0;
        lable.font = [UIFont systemFontOfSize:16];
        [view addSubview:lable];
        [lableArr addObject:lable];
    }
    


   
}


 -(void)drawTabar
{
    //--------tabbar按钮--------
    
    static UIView *viewTab;
    viewTab = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64, self.view.frame.size.width, 64)];
    viewTab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [self.view addSubview:viewTab];
    
    UIButton *Lbutton = [[UIButton alloc] initWithFrame:CGRectMake(10, 7, 35, 30)];
    [Lbutton setImage:[UIImage imageNamed:@"test_left.png"] forState:UIControlStateNormal];
    Lbutton.tag = 6;
    [Lbutton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [viewTab addSubview:Lbutton];
    
    UIButton *Tbt = [[UIButton alloc] initWithFrame:CGRectMake(75, 7, 35, 30)];
    [Tbt setImage:[UIImage imageNamed:@"test_weizuo.png"] forState:UIControlStateNormal];
    Tbt.tag = 7;
    [Tbt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [viewTab addSubview:Tbt];
    //------commit
    UIButton *commitBt = [[UIButton alloc] initWithFrame:CGRectMake(210, 7, 35, 30)];
    [commitBt setImage:[UIImage imageNamed:@"test_commit.png"] forState:UIControlStateNormal];
    commitBt.tag = 8;
    [commitBt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [viewTab addSubview:commitBt];
    
    UIButton *Rbutton = [[UIButton alloc] initWithFrame:CGRectMake(275, 7, 35, 30)];
    [Rbutton setImage:[UIImage imageNamed:@"test_next.png"] forState:UIControlStateNormal];
    Rbutton.tag = 9;
    [Rbutton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [viewTab addSubview:Rbutton];
    
    //----tabarlable
    UILabel *lableName1 = [[UILabel alloc] initWithFrame:CGRectMake(5  ,40, 50, 15)];
    lableName1.text = [labarArr objectAtIndex:0];
    lableName1.textColor = [UIColor whiteColor];
    lableName1.font = [UIFont systemFontOfSize:14];
    [viewTab addSubview:lableName1];
    
    UILabel *lableName2 = [[UILabel alloc] initWithFrame:CGRectMake(75  ,40, 40, 15)];
    lableName2.text = [labarArr objectAtIndex:1];
    lableName2.textColor = [UIColor whiteColor];
    lableName2.font = [UIFont systemFontOfSize:14];
    [viewTab addSubview:lableName2];
    
    UILabel *lableName3 = [[UILabel alloc] initWithFrame:CGRectMake(120  ,40, 100, 15)];
    lableName3.text = [labarArr objectAtIndex:2];
    lableName3.textColor = [UIColor whiteColor];
    lableName3.font = [UIFont systemFontOfSize:14];
    [viewTab addSubview:lableName3];
    
    UILabel *lableName4 = [[UILabel alloc] initWithFrame:CGRectMake(210  ,40, 40, 15)];
    lableName4.text = [labarArr objectAtIndex:3];
    lableName4.textColor = [UIColor whiteColor];
    lableName4.font = [UIFont systemFontOfSize:14];
    [viewTab addSubview:lableName4];
    
    UILabel *lableName5 = [[UILabel alloc] initWithFrame:CGRectMake(265  ,40, 50, 15)];
    lableName5.text = [labarArr objectAtIndex:4];
    lableName5.textColor = [UIColor whiteColor];
    lableName5.font = [UIFont systemFontOfSize:14];
    [viewTab addSubview:lableName5];
    
    //显示时间
    timeLbale = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, 80, 20)];
    timeLbale.text = @"00:00";
    timeLbale.textColor = [UIColor whiteColor];
    [viewTab addSubview:timeLbale];
    
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


#pragma mark -更新时间
-(void)updateTime
{
    if (timeDate == 0) {
        [timer invalidate];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"时间已到"
                                                           delegate:self
                                                  cancelButtonTitle:@"提交"
                                                  otherButtonTitles:@"不提交退出答题",nil];
        alertView.tag = 9502;
        [alertView show];
        
    }else{

        timeDate = timeDate - 1 > 0 ? timeDate - 1 : 0;
        timeLbale.text = [self getTime];
    }
}

-(NSString*)getTime {
    
    int imin = (int)(timeDate / 60);
    int isec = (int)(timeDate % 60);
    
    NSString *min = [NSString stringWithFormat:@"%@%d", imin < 10 ? @"0" : @"", imin];
    NSString *sec = [NSString stringWithFormat:@"%@%d", isec < 10 ? @"0" : @"", isec];
    NSString *addTime = [NSString stringWithFormat:@"%@:%@", min, sec];
    return addTime;
}

#pragma mark  -底部状态的栏的显示关闭
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
