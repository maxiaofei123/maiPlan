//
//  M_selfViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_selfViewController.h"
#import "self_setPageViewController.h"

@interface M_selfViewController ()
{
    NSArray *nameArr;
}

@end

@implementation M_selfViewController
@synthesize tableView;

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
    
    nameArr = [[NSArray alloc] initWithObjects:@"昵称:",@"性别:",@"手机:",@"航校:", nil];
    
    


    [self drawNav];
    [self drawView];
    
    }

-(void)drawView
{
//-----------------------
    UIImageView * topView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 105, 300, 65)];
    topView.image = [UIImage imageNamed:@"my_change.png"];
    [topView setUserInteractionEnabled:YES];
    [self.view addSubview:topView];

    UIButton * headBt =[UIButton buttonWithType:UIButtonTypeCustom];
    headBt.frame =CGRectMake(260, 20, 25, 22);
    [headBt setImage:[UIImage imageNamed:@"my_quan.png"] forState:UIControlStateNormal];
    headBt.tag = 1;
    [headBt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:headBt];

    //---tableview
    UIImageView * v= [[UIImageView alloc] initWithFrame:CGRectMake(10, 190, 300, 160)];
    v.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"set_shang.png"]];
    [v setUserInteractionEnabled:YES];
    [self.view addSubview:v];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 190, 300, 160)];
    tableView.delegate =self;
    tableView.dataSource =self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];
    
//-----最高成绩---------------
    UILabel *lableScore = [[UILabel alloc] initWithFrame:CGRectMake(10, 370, 100, 20)];
    lableScore.backgroundColor = [UIColor clearColor];
    lableScore.text = @"最高成绩";
    lableScore.font = [UIFont systemFontOfSize:18];
    lableScore.textColor = [UIColor blackColor];
    [self.view addSubview:lableScore];
    
    UIImageView *scoreView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 400, 300, 60)];
    scoreView.image = [UIImage imageNamed:@"my_baikuang.png"];
    [scoreView setUserInteractionEnabled:YES];
    [self.view addSubview:scoreView];
    
    UILabel *lilun = [[UILabel alloc] initWithFrame:CGRectMake(10, 17, 100, 20)];
    lilun.text = @"私照理论:";
    lilun.font = [UIFont systemFontOfSize:18];
    lilun.textColor = [UIColor blackColor];
    [scoreView addSubview:lilun];
    
//-----添加按钮
    UIButton * lilunBt = [[UIButton alloc] initWithFrame:CGRectMake(260, 20, 25, 22)];
    //lilunBt =[UIButton buttonWithType:UIButtonTypeCustom];
    [lilunBt setImage:[UIImage imageNamed:@"my_quan.png"] forState:UIControlStateNormal];
    lilunBt.tag = 6;
    [lilunBt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [scoreView addSubview:lilunBt];
    
    


}

- (void)drawNav
{
    UIView *view;

    view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [self.view addSubview:view];
    
    
    UILabel *title;
    title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, view.frame.size.width-120, 44)];
    
    title.backgroundColor = [UIColor clearColor];
    title.text = @"我的个人主页";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
}

-(void)choose:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
            NSLog(@"tag=%d",sender.tag);
            
            break;
        case 2:
            NSLog(@"tag=%d",sender.tag);
            
            break;
        case 3:
            NSLog(@"tag=%d",sender.tag);
            
            break;
        case 4:
            NSLog(@"tag=%d",sender.tag);
            
            break;
        case 5:
            NSLog(@"tag=%d",sender.tag);
            
            break;
        case 6:
            NSLog(@"tag=%d",sender.tag);
            break;
            
            
        default:
            break;
    }


}

#pragma mark -tableview

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 39.5, 300,0.5)];
    line.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.77 alpha:1];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cell addSubview:line];
    
    NSInteger row = [indexPath row];

    cell.textLabel.text =[nameArr objectAtIndex:row];
    UIButton *tableBt = [[UIButton alloc] initWithFrame:CGRectMake(260, 10, 25, 22)];
   
    [tableBt setImage:[UIImage imageNamed:@"my_quan.png"] forState:UIControlStateNormal];
    tableBt.tag = row+2;
    [tableBt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:tableBt];
    
        //取消点选效果
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
