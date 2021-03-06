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
#import "Exam_checkViewController.h"
#import "Exam_rankingListViewController.h"
#import "M_regViewController.h"

@interface Exam_resultViewController ()<UIActionSheetDelegate>
{
    NSArray *lableArr;
    UINavigationBar * nav;
    
}
@end

@implementation Exam_resultViewController
@synthesize useTime , resultScore,useSec ,checkDic,zhuangtai;

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
    [self commit];
}

-(void)commit
{
    NSString *str =[[NSString alloc] initWithFormat:@"http://42.120.9.87:4010/api/scores?auth_token=%@&score[user_id]=%@&score[number]=%.2f",[[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"], [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],resultScore];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        NSLog(@"resu =%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"error +%@",error);
    }];
    
}


-(void)drawView
{
    NSString * token =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    if (token ==nil ) {
        token =@"";
    }    

    UILabel * userLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 140, 200, 20)];
    userLable.text = [NSString stringWithFormat:@"%@:",token];
    userLable.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:userLable];
    
    UILabel * tishiL = [[UILabel alloc] initWithFrame:CGRectMake(50, 165, 270, 30)];
    tishiL.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:tishiL];
    if (resultScore < 90) {
        tishiL.text =@"您的飞行梦想折断了双翼,请继续努力!";
    }else
    {
        tishiL.text =@"您离飞行梦想更近了一步,恭喜您!";
    }
    
    for (int i =0 ; i<3; i++) {
        UILabel * Lable =[[UILabel alloc] initWithFrame:CGRectMake(50, 220+i*30, 200, 20)];
        if (i==0) {
            Lable.text = [NSString stringWithFormat:@"%@  %.2f   分",[lableArr objectAtIndex:i],resultScore];
        }
        else if (i ==1 ) {
            Lable.text = [NSString stringWithFormat:@"%@  %d   分  %d   秒",[lableArr objectAtIndex:i],useTime,useSec];
        }
        else{
            Lable.text =[lableArr objectAtIndex:i];
        }
        [self.view addSubview:Lable];
    }
}

- (void)drawNav
{
    static UIView *view;
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 49)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [self.view addSubview:view];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, view.frame.size.width-120, 49)];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"考试结果";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
    
    UIButton *lButton =[[UIButton alloc] init];
    lButton =[UIButton buttonWithType:0];
    [lButton setImage:[UIImage imageNamed:@"result_tuichu.png"] forState:UIControlStateNormal];
    [lButton setFrame:CGRectMake(10, 9, 30, 30)];
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
    [Lbutton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:Lbutton];
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 80, 20)];
    lable1.text =@"查看答案";
    lable1.font = [UIFont systemFontOfSize:16];
    lable1.textColor = [UIColor whiteColor];
    [view addSubview:lable1];
    
    
    UIButton *Rbutton = [[UIButton alloc] initWithFrame:CGRectMake(267, 7, 35, 30)];
    [Rbutton setImage:[UIImage imageNamed:@"result_paihang.png"] forState:UIControlStateNormal];
    Rbutton.tag = 4;
    [Rbutton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
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
            
        }
            break;
            
        case 2:
        {
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信好友",@"分享到朋友圈", nil];
            [sheet showInView:self.view];
        }
        
            
            break;
        case 3:
        {//查看答案“
            
            Exam_checkViewController *check = [[Exam_checkViewController alloc] init];
            check.wrDic =checkDic;
            check.zhuangtaiDic =zhuangtai;
            [self.navigationController pushViewController:check animated:YES];
        
        }
            break;
        case 4:
        {
            Exam_rankingListViewController * rank = [[Exam_rankingListViewController alloc] init];
            [self.navigationController pushViewController:rank animated:YES];
        
        }
            
            break;
            
        default:
            break;
    }

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [M_public sendLinkContent:0];
    }else if (buttonIndex == 1){
        [M_public sendLinkContent:1];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
