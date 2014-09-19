//
//  M_setViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_setViewController.h"




@interface M_setViewController ()
{
    NSArray * nameArr;
    
    NSString * version;
}

@end

@implementation M_setViewController

@synthesize setTableView;

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
    
    nameArr = [[NSArray alloc] initWithObjects:@"检查更新",@"帮助和反馈",@"关于",nil];
    
    [self drawNav];
    [self drawView];
    
}


-(void)drawView
{
    //tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, 300, 200) style:UITableViewStyleGrouped];
    setTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 100, 280, 200)];
    setTableView.delegate = self;
    setTableView.dataSource =self;
    setTableView.backgroundColor = [UIColor clearColor];
    self.setTableView.showsVerticalScrollIndicator = NO;
    setTableView.scrollEnabled = NO;
    [self.view addSubview:setTableView];

}


- (void)drawNav
{
    UIView *view;

    view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 49)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [self.view addSubview:view];
    
    
    UILabel *title;
    title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, view.frame.size.width-120, 49)];
    
    title.backgroundColor = [UIColor clearColor];
    title.text = @"设置管理";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
}

#pragma mark -TableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
       static NSString *tableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }


    cell.textLabel.text =[nameArr objectAtIndex:row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 39.5, 300,0.5)];
    line.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.77 alpha:1];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cell addSubview:line];
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    switch (indexPath.row) {
            
        case 0://检查更新
            [self onCheckVersion];
            
            break;
        case 1://帮助和反馈
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"帮助反馈" message:@"有问题或建议请发邮件至service@mfeiji.com" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        
        }
            break;
        case 2://关于
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"关于" message:@"MfeijiAPP 1.0" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
            break;
            
        default:
            break;
    }
    

    
}
////更新应用程序
-(void)onCheckVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://42.120.9.87:4010/api/version?" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        version = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"version"]];
        if (![version isEqualToString:currentVersion]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"更新", nil];
            alert.tag = 10000;
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新" message:@"此版本为最新版本" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 10001;
            [alert show];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请查看网络是否链接?"
                                                           delegate:self
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
 
    
    
    
}

-(void)requestVersion
{
      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://42.120.9.87:4010/api/version?" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        version = [responseObject objectForKey:@"version"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请查看网络是否链接?"
                                                           delegate:self
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    NSLog(@",,,,%@",version);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/mai-fei-ji/id920281189?l=zh&ls=1&mt=8"];
            [[UIApplication sharedApplication]openURL:url];
        }
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
