//
//  Exam_rankingListViewController.m
//  Mfeiji
//
//  Created by susu on 14-9-11.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "Exam_rankingListViewController.h"

@interface Exam_rankingListViewController ()
{
    NSArray * titleArr;
    UIScrollView * scrollView;
    
    NSMutableArray *nameArr;
    NSMutableArray *soreArr;
    
    int numer ;
}

@end

@implementation Exam_rankingListViewController

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
    
    [self drawNav];
    [self request];
   
}

-(void)drawView
{
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 320, 30)];
    titleLable.text = @"    用户昵称           成绩              排名";
    titleLable.textColor = [UIColor blackColor];
    titleLable.font =[UIFont systemFontOfSize:16];
    [self.view addSubview:titleLable];
    
    scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, self.view.frame.size.height-100)];
    scrollView.contentSize = CGSizeMake(320, 400);
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    NSLog(@"nu =%d",numer);
    for (int i=0; i<numer; i++) {
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 5 + i*40, 90, 30)];
        nameLable.textColor = [UIColor blackColor];
        nameLable.textAlignment = 1;
        nameLable.text = [NSString stringWithFormat:@"%@",[nameArr objectAtIndex:i]];
        
        [scrollView addSubview:nameLable];
        
        UILabel *scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 5 + i*40, 100, 30)];
        scoreLable.textColor = [UIColor blackColor];
        scoreLable.textAlignment = 1;
        scoreLable.text = [NSString stringWithFormat:@"%@ 分",[soreArr objectAtIndex:i]];
        [scrollView addSubview:scoreLable];
        
        UILabel *paiLable = [[UILabel alloc] initWithFrame:CGRectMake(200, 5+i*40, 100, 30)];
        paiLable.textColor =[UIColor blackColor];
        paiLable.textAlignment =1;
        paiLable.text = [NSString stringWithFormat:@"第  %d  名",i+1];
        [scrollView addSubview:paiLable];
    }


}

-(void)request
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://42.120.9.87:4010/api/scores/topten" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *dic=responseObject;
//        NSLog(@"textname=%@",dic);
        NSArray * arr = [dic objectForKey:@"scores"];
        numer =arr.count;
        nameArr =[[NSMutableArray alloc] init];
        soreArr = [[NSMutableArray alloc] init];
        for (int i= 0; i<arr.count; i++) {
  
            [nameArr addObject:[[arr objectAtIndex:i] objectForKey:@"username"]];
            [soreArr addObject:[[arr objectAtIndex:i] objectForKey:@"number"]];
        }
         [self drawView];
//        NSLog(@"username =%@  fenshu =%@",nameArr,soreArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请求失败，请查看网络连接"
                                                           delegate:self
                                                  cancelButtonTitle:@"开始"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
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
    title.text = @"成绩排行";
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
    
}
-(void)choose:(UIButton *)sender
{
            
    [self.navigationController popViewControllerAnimated:YES];
            
}

@end
