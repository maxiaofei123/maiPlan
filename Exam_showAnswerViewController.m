//
//  Exam_showAnswerViewController.m
//  Mfeiji
//
//  Created by susu on 14-9-11.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "Exam_showAnswerViewController.h"

@interface Exam_showAnswerViewController ()<UIScrollViewDelegate>
{
    UIScrollView * scrollView;
    NSArray * textName;
    UILabel *testLable;
    UILabel *anwserLable;
    int  textId;
    
    NSArray * qusetionAnwser;
    NSArray * abcArr;
    
    NSDictionary * zhuangtaiDic;
    NSMutableArray *anwserText;
    
    NSMutableArray *buttonArr;
    NSMutableArray *lableArr;
   
}

@end

@implementation Exam_showAnswerViewController

@synthesize showDic;

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

    textName = [[NSArray alloc] initWithObjects:[showDic objectForKey:@"textName"], nil];
    zhuangtaiDic = [[NSDictionary alloc]initWithDictionary:[showDic objectForKey:@"zhuangtai"]];
    qusetionAnwser = [[NSArray alloc] initWithObjects:[showDic objectForKey:@"answer"], nil];
    abcArr = [[NSArray alloc] initWithObjects:@"A、",@"B、",@"C、", nil];

    
    [self drawNav];
    [self drawView];
    [self drawTabar];
}


-(void)setQuestion:(int)number
{
    
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
        NSLog(@"arr =%@",arr);
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
                
            }
            
            if ((lable.frame.size.height+lable.frame.origin.y)>(self.view.frame.size.height -64)) {
                scrollView.contentSize = CGSizeMake(320, (lable.frame.size.height+lable.frame.origin.y)-100-64);
            }
            
            
            //设置button的 fram
            
            UIButton *cBt = [buttonArr objectAtIndex:i];
            cBt.frame = CGRectMake(40, lable.frame.origin.y-6, 30, 30);
            
        }
        
        
        
    }
}


-(void)drawView
{
    
    testLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 280, 30)];
    testLable.lineBreakMode = NSLineBreakByWordWrapping;
    testLable.numberOfLines = 0;
    testLable.font = [UIFont systemFontOfSize:15.0];
    [scrollView addSubview:testLable];
    
    
    buttonArr =[[NSMutableArray alloc] init];
    lableArr = [[NSMutableArray alloc] init];
    for (int i=0; i<3; i++) {
        UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(40,80+ 50*i, 30, 30)];
        [bt setImage:[UIImage imageNamed:@"test_Bt.png"] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:@"test_Bt1.png"] forState:UIControlStateSelected];
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


-(void)choose:(UIButton *)sender
{
    switch (sender.tag) {
            
        case 1:
    
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
        case 2:{
                    }
            
            break;
        case 6://上一题
        {
            textId = textId ==0 ? 0 :textId -1;
            NSString * valueStr = [[NSString alloc] init];
            valueStr =[zhuangtaiDic objectForKey:[NSString stringWithFormat:@"%d",textId]];
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
                    }
            break;
        case 9://下一题
        {
            textId =textId == (textName.count-1) ? (textName.count-1) :textId + 1;
            NSString * valueStr = [[NSString alloc] init];
            
            valueStr =[zhuangtaiDic objectForKey:[NSString stringWithFormat:@"%d",textId]];
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
            
        }
            
            break;
            
        default:
            break;
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
    title.text = @"试题答案";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
    UIButton *lButton =[[UIButton alloc] init];
    lButton =[UIButton buttonWithType:0];
    [lButton setImage:[UIImage imageNamed:@"home_back.png"] forState:UIControlStateNormal];
    [lButton setFrame:CGRectMake(5, 7, 30, 30)];
    lButton.tag = 1;
    [lButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lButton];
    
    
    UIImageView * topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 40)];
    topView.image = [UIImage imageNamed:@"test_lan.png"];
    [self.view addSubview:topView];
    //---------lable---
    UILabel *userNO = [[UILabel alloc] initWithFrame:CGRectMake(30, 9, 120,  20)];
    userNO.text = [NSString stringWithFormat:@"学生序号: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]];
    userNO.textColor = [UIColor whiteColor];
    userNO.font = [UIFont systemFontOfSize:16];
    [topView addSubview:userNO];
    
    UILabel *userLable = [[UILabel alloc] initWithFrame:CGRectMake(170, 9, 150,  20)];
    userLable.text = [NSString stringWithFormat:@"学生姓名: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    userLable.textColor = [UIColor whiteColor];
    userLable.font = [UIFont systemFontOfSize:16];
    [topView addSubview:userLable];
    
    
    //---------考试题目---------
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, self.view.frame.size.height -100-64)];
    [scrollView setUserInteractionEnabled:YES];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate =self;
    scrollView.contentSize = CGSizeMake(320,self.view.frame.size.height -100-64);
    [self.view addSubview:scrollView];
    
}


-(void)drawTabar
{
    //--------tabbar按钮--------
    
    static UIView *viewTab;
    viewTab = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64, self.view.frame.size.width, 64)];
    viewTab.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [self.view addSubview:viewTab];
    
    UIButton *Lbutton = [[UIButton alloc] initWithFrame:CGRectMake(20, 7, 35, 30)];
    [Lbutton setImage:[UIImage imageNamed:@"test_left.png"] forState:UIControlStateNormal];
    Lbutton.tag = 6;
    [Lbutton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [viewTab addSubview:Lbutton];
    
    
    UIButton *Rbutton = [[UIButton alloc] initWithFrame:CGRectMake(265, 7, 35, 30)];
    [Rbutton setImage:[UIImage imageNamed:@"test_next.png"] forState:UIControlStateNormal];
    Rbutton.tag = 9;
    [Rbutton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [viewTab addSubview:Rbutton];
    
    //----tabarlable
    UILabel *lableName1 = [[UILabel alloc] initWithFrame:CGRectMake(25  ,40, 50, 15)];
    lableName1.text = @"上一题";
    lableName1.textColor = [UIColor whiteColor];
    lableName1.font = [UIFont systemFontOfSize:14];
    [viewTab addSubview:lableName1];
    
    
    UILabel *lableName5 = [[UILabel alloc] initWithFrame:CGRectMake(255  ,40, 50, 15)];
    lableName5.text = @"下一题";
    lableName5.textColor = [UIColor whiteColor];
    lableName5.font = [UIFont systemFontOfSize:14];
    [viewTab addSubview:lableName5];
    
    
    UILabel *lableNameId = [[UILabel alloc] initWithFrame:CGRectMake(135  ,20, 60, 20)];
    lableNameId.text = [NSString stringWithFormat:@"%d / 80 ",textId];
    lableNameId.textColor = [UIColor whiteColor];
    lableNameId.font = [UIFont systemFontOfSize:18];
    [viewTab addSubview:lableNameId];
    
    
    

    
}

@end
