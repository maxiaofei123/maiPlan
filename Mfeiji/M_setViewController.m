//
//  M_setViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_setViewController.h"
#import "SevenSwitch.h"



@interface M_setViewController ()
{
    NSArray * nameArr;
}

@end

@implementation M_setViewController

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
    
    nameArr = [[NSArray alloc] initWithObjects:@"检查更新",@"帮助和反馈",@"关于",nil];
    
    [self drawNav];
    [self drawView];
    
}


-(void)drawView
{
    //tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 80, 300, 200) style:UITableViewStyleGrouped];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 100, 280, 200)];
    tableView.delegate = self;
    tableView.dataSource =self;
    tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    tableView.scrollEnabled = NO;
    [self.view addSubview:tableView];

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

    
//    switch (section) {
//        case 0:
//            cell.textLabel.text =[nameArr objectAtIndex:row];
//            if (row == 0 || row == 4) {
//              
//            }
//            else//添加开关
//            {
//                [cell setSelectionStyle:UITableViewCellEditingStyleNone];//取消cell点击效果
//                
//                SevenSwitch * mySwithch = [[SevenSwitch alloc]initWithFrame:CGRectMake(260, 20, 40, 20)];
//                mySwithch.center = CGPointMake(260, 20);
//                [mySwithch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//                mySwithch.offImage = [UIImage imageNamed:@"switch_off1.png"];
//                mySwithch.onImage = [UIImage imageNamed:@"switch_on.png"];
//                mySwithch.onColor = [UIColor colorWithHue:0.08f saturation:0.74f brightness:1.00f alpha:1.00f];
//                mySwithch.tag = row;
//                mySwithch.isRounded = NO;
//                [cell addSubview:mySwithch];
//            }
//
//            break;
//        case 1:
//          //  cell.textLabel.text =[nameArr objectAtIndex:row];
//            break;
//            
//        default:
//            break;
//       }
    cell.textLabel.text =[nameArr objectAtIndex:row];
    cell.font = [UIFont systemFontOfSize:14];
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
//    if (section == 0) {
//        return 5;
//    }
//    else
//    {
//        return 3;
//    }
    
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

- (void)switchChanged:(SevenSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
    switch (sender.tag) {
        case 1:
            if (sender.on) {
                [self onCheckVersion];
                 NSLog(@"sender on ");
            }else
            {
                
            }
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
}

#pragma mark -wifii
//更新应用程序
-(void)onCheckVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDic));
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    
    NSString *URL = @"http://itunes.apple.com/lookup?id=com.exhibition.ideer";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URL]];
    [request setHTTPMethod:@"POST"];
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [results JSONValue];

    NSArray *infoArray = [dic objectForKey:@"results"];
    NSLog(@"info=%@",infoArray);
    if ([infoArray count]) {
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *lastVersion = [releaseInfo objectForKey:@"version"];
        
        if (![lastVersion isEqualToString:currentVersion]) {
          
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
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==10000) {
        if (buttonIndex==1) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com"];
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
