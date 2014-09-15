//
//  M_examViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_examViewController.h"
#import "Exam_testViewController.h"
#import "M_homeViewController.h"
#import "M_regViewController.h"

static NSDictionary * dic;

@interface M_examViewController ()<UIAlertViewDelegate>
{
    NSArray *lableArr;
    UIButton * select1;
    UIButton * select2;
    UIButton * select3;
    int  btSelectTag;
    
    
    
    UITextField *Password;
    UITextField *UserName;

}

@end

@implementation M_examViewController


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
    [self showTabBar];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-20)];
    view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"exam_bg.png"]];
    [self.view addSubview:view];
    lableArr = [[NSArray alloc] initWithObjects:@"全面学习模式", @"未答过题模式",@"复习错题模式",nil];
    
   
    
    [self drawNav];
    [self drawView];
    
    
}

-(void)drawView
{
// ------用户名和密码框 and text----
    UIImageView *userView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 100, 210, 50)];
    userView.image = [UIImage imageNamed:@"exam_user.png"];
    [userView setUserInteractionEnabled:YES];
    [self.view addSubview:userView];
    UserName = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, 170, 50)];
    UserName.placeholder = @"输入用户名/邮箱";
    UserName.delegate =self;
    UserName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    UserName.font = [UIFont systemFontOfSize:16];
    UserName.textColor = [UIColor whiteColor];
    [userView addSubview:UserName];
    
    
    UIImageView *pwdView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 160, 210, 50)];
    pwdView.image = [UIImage imageNamed:@"exam_pwd.png"];
    [pwdView setUserInteractionEnabled:YES];
    [self.view addSubview:pwdView];
    
    Password = [[UITextField alloc] initWithFrame:CGRectMake(40, 0, 170, 50)];
    Password.placeholder = @"请输入密码";
    Password.secureTextEntry = YES;
    Password.delegate =self;
    Password.font = [UIFont systemFontOfSize:16];
    Password.textColor = [UIColor whiteColor];
    [pwdView addSubview:Password];
    
//---------开始考试------
        UIButton *startBt = [[UIButton alloc] initWithFrame:CGRectMake(100, 225, 130, 40)];
        [startBt setImage:[UIImage imageNamed:@"exam_start.png"] forState:UIControlStateNormal];
        startBt.tag = 6;
        [startBt addTarget:self action:@selector(pangdan) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:startBt];
 //------不登陆直接考试--
        UIButton *noLogin = [[UIButton alloc] initWithFrame:CGRectMake(100, 305, 130, 40)];
        [noLogin setImage:[UIImage imageNamed:@"exam_budenglu.png"] forState:UIControlStateNormal];
        noLogin.tag = 7;
        [noLogin addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:noLogin];
        
//------我要注册---
        UIButton *zhuce = [[UIButton alloc] initWithFrame:CGRectMake(105, 360, 120, 30)];
        [zhuce setImage:[UIImage imageNamed:@"exam_woyaozhuce.png"] forState:UIControlStateNormal];
        zhuce.tag = 8;
        [zhuce addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:zhuce];
    
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
    title.text = @"私用飞行器理论考试";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
    UIButton *homeBt =[[UIButton alloc] initWithFrame:CGRectMake(13, 10, 30 , 30)];
    [homeBt setImage:[UIImage imageNamed:@"public_home.png"] forState:UIControlStateNormal];
    homeBt.tag =1;
    [homeBt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:homeBt];
    
    UIButton *rButton =[[UIButton alloc] init];
    rButton =[UIButton buttonWithType:0];
    [rButton setImage:[UIImage imageNamed:@"topR.png"] forState:UIControlStateNormal];
    [rButton setFrame:CGRectMake(275, 10, 30, 30)];
    rButton.tag = 2;
    [rButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rButton];

}

-(void)choose:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
        
        }
            break;
        case 2:
        {
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信好友",@"分享到朋友圈", nil];
            [sheet showInView:self.view];
        }
            
            break;
        case 3:
        {
            select1.selected = YES;
            select2.selected =NO;
            select3.selected =NO;
            btSelectTag =1;
        }
            
            break;
        case 4:
        {
            select1.selected = NO;
            select2.selected =YES;
            select3.selected =NO;
            btSelectTag =2;
        }
            break;
        case 5:
        {
            select1.selected = NO;
            select2.selected =NO;
            select3.selected =YES;
            btSelectTag =3;
        }
            
            break;
            
        case 7:
        {
                        
             _testView = [[Exam_testViewController alloc] init];
            [self.navigationController pushViewController:_testView animated:NO];
        }
            break;
        case 8:
            {
                M_regViewController * reg = [[M_regViewController alloc] init];
                [self.navigationController pushViewController:reg animated:YES];
        
            }
            
            break;
            
            
        default:
            break;
    }

}

//登陆成功后进入考试界面
-(void)pangdan
{

    NSString * to =[[NSUserDefaults standardUserDefaults] objectForKey:@"auth_token"];
    NSString * userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
    if (UserName.text.length >0 && Password.text.length >0) {
        [self login];
    }else{
        if (to.length>0 && userid.length >0) {
            //进入考试
            _testView = [[Exam_testViewController alloc] init];
            [self.navigationController pushViewController:_testView animated:NO];
            
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"您还没有登陆，请先登录"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:@"返回",nil];
            alertView.tag =1009;
            [alertView show];
        }
    }

}


-(void)login
{
    NSString * msg = @"ok";
    if (!([UserName.text length]>0)) {
        msg =@"请输入用户名";
    }
    else if(Password.text.length <6 || Password.text.length >20)
    {
        msg =@"请输入6-20位密码";
    
    }
    
    if ([msg isEqualToString:@"ok"]) {
    
        NSDictionary * dic =[[NSDictionary alloc] initWithObjectsAndKeys:UserName.text,@"user[login]",Password.text,@"user[password]", nil];
 
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:[NSString stringWithFormat:@"http://42.120.9.87:4010/api/user_tokens?"] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary * res;
            res = [responseObject objectForKey:@"user_token"];
            NSLog(@"res =%@",res);
            [[NSUserDefaults standardUserDefaults] setObject:[res objectForKey:@"token"] forKey:@"auth_token"];
            [[NSUserDefaults standardUserDefaults] setObject:[res objectForKey:@"user_id"] forKey:@"userId"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",UserName.text] forKey:@"username"];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"登陆成功"
                                                               delegate:self
                                                      cancelButtonTitle:@"进去答题"
                                                      otherButtonTitles:@"返回",nil];
            alertView.tag = 1001;
            [alertView show];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error=%@",error);
            NSString *msgStr =@"登陆失败 ,请检查网络";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:msgStr
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];

    }
    else{
        

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"ale%d    %d",alertView.tag,buttonIndex);
    if (alertView.tag ==1001) {
        if (buttonIndex ==0) {
            //进入考试
            _testView = [[Exam_testViewController alloc] init];
            [self.navigationController pushViewController:_testView animated:NO];
           
        }
        
    }
    else if(alertView.tag ==1009)
    {
        if (buttonIndex ==0) {
            [self login];
        }
    }
}

//........

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UserName resignFirstResponder];
    [Password resignFirstResponder];
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
