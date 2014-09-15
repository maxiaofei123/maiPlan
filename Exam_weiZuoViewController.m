//
//  Exam_weiZuoViewController.m
//  Mfeiji
//
//  Created by susu on 14-9-12.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "Exam_weiZuoViewController.h"


@interface Exam_weiZuoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * checkTableView;
    int questionNumber;
}
@end

@implementation Exam_weiZuoViewController
@synthesize weidaArry ,delegate;

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
    UIScrollView *tableScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height -64)];
    tableScroll.contentSize = CGSizeMake(320, 64*16);
    [view addSubview:tableScroll];
    
    checkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height -64)];
    checkTableView.delegate =self;
    checkTableView.dataSource =self;
    checkTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //    checkTableView.scrollEnabled = NO;
    checkTableView.backgroundColor =[UIColor clearColor];
    [view addSubview:checkTableView];
    
    [self drawNav];
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
    title.text = @"考试答案";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
    UIButton *lButton =[[UIButton alloc] init];
    lButton =[UIButton buttonWithType:0];
    [lButton setImage:[UIImage imageNamed:@"home_back.png"] forState:UIControlStateNormal];
    [lButton setFrame:CGRectMake(10, 9, 30, 30)];
    lButton.tag = 111;
    [lButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lButton];
    
    
    //    NSLog(@"check =%@",wrDic);
    
    
}
-(void)choose:(UIButton *)sender
{
    if (sender.tag ==111) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else
    {
        [delegate setQuestion:(sender.tag-1)];
        [self.navigationController popViewControllerAnimated:YES];
    }    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
        
    }else{
        [cell removeFromSuperview];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }
    
    
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];//取消cell点击效果
    
    
    cell.backgroundColor= [UIColor clearColor];
    
    UIView * line =[[UIView alloc] initWithFrame:CGRectMake(0, 63.5, 320, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha =1;
    [cell.contentView addSubview:line];
    if (indexPath.row ==0) {
        UIView * line1 =[[UIView alloc] initWithFrame:CGRectMake(0, 0.5, 320, 0.5)];
        line1.backgroundColor = [UIColor grayColor];
        line1.alpha =1;
        [cell.contentView addSubview:line1];
    }
    for (int i =0; i< 5; i++) {
        //题号
        if ((indexPath.row*5 +(i + 1))<weidaArry.count) {
            NSString * str = [weidaArry objectAtIndex:(indexPath.row*5 +(i + 1))];
            UIButton * bt = [[UIButton alloc] initWithFrame:CGRectMake(64*i, 0.5, 63, 63.5)];
            [bt setTitle:[NSString stringWithFormat:@"%@",[weidaArry objectAtIndex:(indexPath.row*5 +(i + 1))]] forState:UIControlStateNormal];
            [bt setTitle:[NSString stringWithFormat:@"%@",[weidaArry objectAtIndex:(indexPath.row*5 +(i + 1))]] forState:UIControlStateSelected];
            bt.titleLabel.textColor = [UIColor blackColor];
            bt.tag = [str intValue] ;
            [bt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:bt];
            
            
            //添加分界线
            UIView * btLine = [[UIView alloc] initWithFrame:CGRectMake(63.5*i, 0, 0.5, 64)];
            btLine.backgroundColor = [UIColor grayColor];
            [cell addSubview:btLine];
        }
    }
     
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 64;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (weidaArry.count%5 >0) {
        return (weidaArry.count/5 +1);
    }
    NSLog(@"weida arr .count =%d",weidaArry.count);
    return (weidaArry.count/5);
}

@end
