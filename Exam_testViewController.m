//
//  Exam_testViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-22.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "Exam_testViewController.h"
#import "Exam_resultViewController.h"
#import "Exam_weiZuoViewController.h"

@interface Exam_testViewController ()<UIScrollViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    NSArray * labarArr;
    NSArray *textName;
    NSArray * abcArr;
    
    NSMutableDictionary *zhuangTaiDic;
    NSMutableArray *buttonArr;
    NSMutableArray *lableArr;
    NSMutableArray *anwserText;
    NSMutableArray *correctArr;
    NSMutableArray *wrongArr;
    NSMutableArray *daduiArr;
    NSMutableArray *weidaArr;
    NSMutableArray *yidaArr;
    
    NSDictionary * checkDic ;
    
    int selectTag;
    int timeDate;
    float  score;
    
    int imin ;
    int isec ;
    
    UILabel * timeLbale;
    UILabel *testLable;
    UILabel *anwserLable;
    
    UIScrollView * scrollView;
    UIImageView *subjectView;
    UIView *contentView;

    
    
    
    NSTimer * timer;
    
}

@end

@implementation Exam_testViewController
@synthesize resultView,returnTag,textId;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-20)];
    view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"hui_bg.png"]];
    [self.view addSubview:view];
    
    
    labarArr = [[NSArray alloc]initWithObjects:@"上一题",@"未做",@"考试倒计时",@"交卷",@"下一题", nil ];
    abcArr = [[NSArray alloc] initWithObjects:@"A、",@"B、",@"C、", nil];
    zhuangTaiDic = [[NSMutableDictionary alloc] init];
    correctArr =[[NSMutableArray alloc] init];
    wrongArr = [[NSMutableArray alloc] init];
    daduiArr = [[NSMutableArray alloc] init];
    yidaArr  = [[NSMutableArray alloc] init];
    
    textId =0;
    score  =0;
    
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer];
    
    
    [self drawNav];
    
    [self drawTabar];
    
    [self hideTabBar];//隐藏tabbar
    [self requestQuestion];
    
    
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"left");
        
        textId =textId == (textName.count-1) ? (textName.count-1) :textId + 1;
        NSString * valueStr = [[NSString alloc] init];
        
        valueStr =[zhuangTaiDic objectForKey:[NSString stringWithFormat:@"%d",textId]];
        int tag = [valueStr  intValue];
        //            NSLog(@"ca,,,,,,,,,,,%d",valueStr.length);
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
        //执行程序
    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right");
        
        //执行程序
        
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
}



-(void)requestQuestion
{
    NSLog(@"requst test ");
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://42.120.9.87:4010/api/exams/question_group.json?" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *dic=responseObject;
        textName=dic[@"question_group"];
//          NSLog(@"textname=%@",textName);
        //   比较每道题的答案是否为一，如果为一，则保存此序号到数组;
        for (int i=0; i< textName.count;i++) {
            for (int j=0; j<3; j++) {
                NSString * str = [[NSString alloc] init];
                NSArray  * arr =[[NSArray alloc] init];
                arr = [[textName objectAtIndex:i] objectForKey:@"options"];
                str = [[arr objectAtIndex:j] objectForKey:@"correct"];
                int number =[str intValue];
                if (number ==1) {
                    
                    [correctArr addObject:[NSString stringWithFormat:@"%d",j]];
                }
            }
        }
        //        NSLog(@"........................=%@",correctArr);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"开始做题了, 准备好了么?"
                                                           delegate:self
                                                  cancelButtonTitle:@"开始"
                                                  otherButtonTitles:nil];
        alertView.tag = 101;
        [alertView show];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请查看网络是否链接?"
                                                           delegate:self
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil];
        alertView.tag = 102;
        [alertView show];
          }];
    
}

-(void)setQuestion:(int)number
{
    
    textId = number;
    if (textName.count ==0) {
        
    }else{
        
        NSString * examStr = [[NSString alloc] init];
        examStr = [[textName objectAtIndex:number] objectForKey:@"subject"];
        UIFont *font = [UIFont systemFontOfSize:18.0];
        CGSize size = CGSizeMake(280, 2000);
        CGSize namelabelsize =[examStr sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        float nameLableH;
        
        nameLableH = testLable.frame.size.height>=namelabelsize.height?namelabelsize.height:20;
        testLable.frame =CGRectMake(30, 10, 280, namelabelsize.height);
        testLable.text = [NSString stringWithFormat:@"%d:  %@",number+1,examStr];
        
        //每个题目下的问题
        anwserText = [[NSMutableArray alloc] init];
        NSArray *arr = [[NSArray alloc] init];
        arr= [[textName objectAtIndex:number] objectForKey:@"options"];
        
        float lableH;
        for (int j= 0; j<3; j++) {
            UILabel *lable=[lableArr objectAtIndex:j];
            lable.frame = CGRectMake(80, 86+j*50, 200, 20);
        }
        for (int i=0; i<arr.count; i++) {
            [anwserText addObject:[[arr objectAtIndex:i] objectForKey:@"content"]];
            UILabel *lable=[lableArr objectAtIndex:i];
            lable.text =[NSString stringWithFormat:@"%@ %@",[abcArr objectAtIndex:i],[anwserText objectAtIndex:i]];
            
            //适应高度
            UIFont *font = [UIFont systemFontOfSize:16.0];
            CGSize size = CGSizeMake(200, 2000);
            CGSize labelsize =[[anwserText objectAtIndex:i] sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];;
            float lableH;
            lableH = lable.frame.size.height>=labelsize.height?labelsize.height:20;
            
            if (i ==0) {
                
                lable.frame = CGRectMake(80, 86+ 50*i + (namelabelsize.height -20), 200, labelsize.height);
                
            }else if(i == 1)
            {
                UILabel *lablea=[lableArr objectAtIndex:0];
                lable.frame =CGRectMake(80,lablea.frame.size.height+lablea.frame.origin.y + 20,200, labelsize.height);
                
            }
            else if( i ==2 )
            {
                UILabel *lableb=[lableArr objectAtIndex:1];
                lable.frame =CGRectMake(80,lableb.frame.size.height+lableb.frame.origin.y+20, 200, labelsize.height);
                lableH =lable.frame.size.height+lable.frame.origin.y;
                
                
            }
//            NSLog(@"lable fram=%f",lableH+30);
            if ((lableH+30)>self.view.frame.size.height-109-64) {
                scrollView.contentSize = CGSizeMake(320, (lable.frame.size.height+lable.frame.origin.y+15));
                
                
            }else
            {
                scrollView.contentSize =CGSizeMake(320,self.view.frame.size.height -109-64);
            }
            //设置button的 fram
            UIButton *cBt = [buttonArr objectAtIndex:i];
            cBt.frame = CGRectMake(40, lable.frame.origin.y-3, 25, 25);
            
        }
    }
}


-(void)choose:(UIButton *)sender
{
    switch (sender.tag) {
            
        case 1:
            
            [timer invalidate];
            timer = nil;
            [self showTabBar];
            [self.navigationController popViewControllerAnimated:NO];
            
            break;
        case 2:{
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信好友",@"分享到朋友圈", nil];
            [sheet showInView:self.view];
        }
            
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
        {
            //跳转未做序号页面
            NSLog(@"已答题 =%@ ",yidaArr);
            weidaArr = [[NSMutableArray alloc] init];
            for (int  i= 0; i<80; i++) {
                int p =0;
                for (int j =0; j<yidaArr.count; j++) {
                    NSString *str =[[NSString alloc]initWithFormat:@"%@",[yidaArr objectAtIndex:j]];
                    if ([str isEqualToString:[NSString stringWithFormat:@"%d",i]]) {
                        p=1;
                        break;
                    }
                }
                if (p == 0) {
                    [weidaArr addObject:[NSString stringWithFormat:@"%d",i]];
                }
                
            }
//            NSLog(@"weida  =%@",weidaArr);
            Exam_weiZuoViewController * weizuo = [[Exam_weiZuoViewController alloc] init];
            weizuo.weidaArry = weidaArr;
            weizuo.delegate =self;
            [self.navigationController pushViewController:weizuo animated:YES];
            
        }
            
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
                [self toResultView];
                
            }
        }
            break;
        case 9://下一题
        {
            textId =textId == (textName.count-1) ? (textName.count-1) :textId + 1;
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
              
                
                
                if (yidaArr.count == 0) {
                     [yidaArr addObject:[NSString stringWithFormat:@"%d",textId]];
                }else{
                    
                    int con =0;
                    for (int i=0; i<yidaArr.count; i++) {
                        NSString * yida = [yidaArr objectAtIndex:i];
                        NSString *test = [NSString stringWithFormat:@"%d",textId];

                        if ([yida isEqualToString:test]) {
                            con =1;
                            break;
                        }
                    }
                    
                    if (con ==0 ) {
                        
                        NSLog(@"不相等");
                        [yidaArr addObject:[NSString stringWithFormat:@"%d",textId]];
                    }
                }
            }else
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
            [self toResultView];
        }
    }
    if (alertView.tag ==9502) {//倒计时为0
        if (buttonIndex ==0) {
            //提交试卷
            [self toResultView];
        }else//退出答题
        {   [timer invalidate];
            [self showTabBar];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    
    if (alertView.tag ==101) {
        if (buttonIndex ==0) {
            [self drawView];
            [self setQuestion:0];
            //实现倒计时
            timeDate =120*60;
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        }
    }
    
    if (alertView.tag == 102) {
        
        [self showTabBar];
        [self.navigationController popViewControllerAnimated:NO];

    }
}


-(void)toResultView
{
    for (int i=0; i<correctArr.count; i++) {
        NSString *str = [[NSString alloc] init];
        NSString *str1 =[[NSString alloc] init];
        str = [correctArr objectAtIndex:i];
        str1 = [zhuangTaiDic objectForKey:[ NSString stringWithFormat:@"%d",i]];
        if (str1.length != 0) {
            if ([str isEqualToString:str1]) {
                float x ;
                x=score;
                score = x+1.25;
                [daduiArr addObject:[NSString stringWithFormat:@"%d",i]];
            }else
                [wrongArr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
    }
    checkDic = [[NSDictionary alloc] initWithObjectsAndKeys:wrongArr,@"wrongArr", daduiArr,@"weidaArr" ,textName,@"textName",correctArr,@"answer",nil, nil];

    [timer invalidate];
    timer = nil;
    resultView =[[Exam_resultViewController alloc] init];
    resultView.hidesBottomBarWhenPushed = NO;
    if (isec != 0) {
        resultView.useTime = 120-imin-1;
        resultView.useSec = 60-isec ;
    }else
    {
        resultView.useTime = 120-imin;
        resultView.useSec = 0 ;
    }
    
    resultView.resultScore = score;
    resultView.checkDic =checkDic;
    resultView.zhuangtai = zhuangTaiDic;
    [self.navigationController pushViewController:resultView animated:NO];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [M_public sendLinkContent:0];
    }else if (buttonIndex == 1){
        [M_public sendLinkContent:1];
    }
}


#pragma mark --绘制页面;
-(void)drawView
{
    
    testLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 280, 20)];
    testLable.lineBreakMode = NSLineBreakByWordWrapping;
    testLable.numberOfLines = 0;
    testLable.font = [UIFont systemFontOfSize:16.0];
    [scrollView addSubview:testLable];
    
    buttonArr =[[NSMutableArray alloc] init];
    lableArr = [[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(40,80+ 50*i, 20, 20)];
        [bt setImage:[UIImage imageNamed:@"40-40.png"] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"40-40_1.png"] forState:UIControlStateSelected];
        bt.tag =3+i;
        bt.selected =NO;
        [bt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:bt];
        [buttonArr addObject:bt];
        
        UILabel *lable =[[UILabel alloc] initWithFrame:CGRectMake(80, 86+i*50, 200, 20)];
        lable.textColor = [UIColor blackColor];
        lable.lineBreakMode = NSLineBreakByWordWrapping;
        lable.numberOfLines = 0;
        lable.textAlignment = 0;
        lable.font = [UIFont systemFontOfSize:16.0];
        [scrollView addSubview:lable];
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
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 49)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [self.view addSubview:view];
    
    
    UILabel *title;
    title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, view.frame.size.width-120, 49)];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"私用飞行器理论考试";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
    UIButton *lButton =[[UIButton alloc] init];
    lButton =[UIButton buttonWithType:0];
    [lButton setImage:[UIImage imageNamed:@"public_home.png"] forState:UIControlStateNormal];
    [lButton setFrame:CGRectMake(5, 10, 30, 30)];
    lButton.tag = 1;
    [lButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lButton];
    
    UIButton *rButton =[[UIButton alloc] init];
    rButton =[UIButton buttonWithType:0];
    [rButton setImage:[UIImage imageNamed:@"topR.png"] forState:UIControlStateNormal];
    [rButton setFrame:CGRectMake(275, 10, 30, 30)];
    rButton.tag = 2;
    [rButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rButton];
    
    
    UIImageView * topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
    topView.image = [UIImage imageNamed:@"test_lan.png"];
    [self.view addSubview:topView];
    //---------lable---
    NSString * Id =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString * token =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    
    if (Id ==nil) {
        Id =@"";
    }
    if (token ==nil ) {
        token =@"";
    }
    UILabel *userNO = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 120,  20)];
    userNO.text = [NSString stringWithFormat:@"学生序号: %@",Id];
    userNO.textColor = [UIColor whiteColor];
    userNO.font = [UIFont systemFontOfSize:16];
    [topView addSubview:userNO];
    
    UILabel *userLable = [[UILabel alloc] initWithFrame:CGRectMake(170, 9, 150,  20)];
    userLable.text = [NSString stringWithFormat:@"学生姓名: %@",token];
    userLable.textColor = [UIColor whiteColor];
    userLable.font = [UIFont systemFontOfSize:16];
    
    [topView addSubview:userLable];
    
    
    //---------考试题目---------
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 109, 320, self.view.frame.size.height -109-64)];
    [scrollView setUserInteractionEnabled:YES];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate =self;
    scrollView.contentSize = CGSizeMake(320,self.view.frame.size.height -109-64);
    [self.view addSubview:scrollView];
    
    
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
    
    imin = (int)(timeDate / 60);
    isec = (int)(timeDate % 60);
    
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



@end
