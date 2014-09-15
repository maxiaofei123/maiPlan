//
//  M_regViewController.m
//  Mfeiji
//
//  Created by susu on 14-8-4.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_regViewController.h"
#import "M_examViewController.h"

@interface M_regViewController ()
{
    UIImageView * viewBg;
    
    UITextField *Password;
    UITextField *UserName;
    UITextField *email;
    UITextField *phoneNumber;
    UITextField *verCode;
    UIButton *getVer;
    
    UIImageView *headView;
    UIImagePickerController *imagePick;
    
    UIScrollView *scroll;
    
    
    NSArray *nameArr;
    
    MBProgressHUD *mb;
}

@end

@implementation M_regViewController

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
    
    nameArr = [[NSArray alloc] initWithObjects:@"昵称:",@"邮箱:",@"密码:", nil];
    
    viewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height)];
    viewBg.userInteractionEnabled = YES;
    viewBg.image =[UIImage imageNamed:@"exam_bg.png"];
    [self.view addSubview:viewBg];
  //定义scroll为了方便上移下移
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewBg.frame.size.width, viewBg.frame.size.height)];
    scroll.backgroundColor = [UIColor clearColor];
    scroll.userInteractionEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    [viewBg addSubview:scroll];
    
    UITapGestureRecognizer *textFeild = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textFieldEditing)];
    [scroll addGestureRecognizer:textFeild];
    
    
    
    [self hideTabBar];
    [self drawNav];
    [self drawView];
}

- (void)drawNav


{
    UIView *view;
    view = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 49)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [scroll addSubview:view];
    
    
    UILabel *title;
    title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, view.frame.size.width-120, 49)];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"用户注册";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
    UIButton *homeBt =[[UIButton alloc] initWithFrame:CGRectMake(13, 7, 28, 27)];
    [homeBt setImage:[UIImage imageNamed:@"home_back.png"] forState:UIControlStateNormal];
    homeBt.tag =1;
    [homeBt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:homeBt];
    
}

-(void)drawView
{
//    headView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 50, 80, 80)];
//    headView.image = [UIImage imageNamed:@"public_head.png"];
//    headView.userInteractionEnabled = YES;
//    [scroll addSubview:headView];
//    UITapGestureRecognizer *pass = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upLoad)];
//    [headView addGestureRecognizer:pass];
    
    
    for (int  i=0; i<3; i++) {
        UILabel * l =[[UILabel  alloc] initWithFrame:CGRectMake(60, 70+80*i, 100, 20)];
        l.text = [nameArr objectAtIndex:i];
        l.textColor = [UIColor whiteColor];
        l.font = [UIFont systemFontOfSize:14];
        [scroll addSubview:l];
        
        UIImageView * v = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100+80*i, 200, 40)];
        if (i==0) {
            v.image = [UIImage imageNamed:@"reg_user.png"];
        }else{
            v.image = [UIImage imageNamed:@"reg_kuang.png"];
        }
        [scroll addSubview:v];
    }
    
    // ------用户名和密码框 and text----
    UserName = [[UITextField alloc] initWithFrame:CGRectMake(70, 105, 185, 30)];
    UserName.placeholder = @"请输入6-15个字符";
    UserName.delegate = self;
    UserName.returnKeyType = UIReturnKeyNext;
    UserName.font = [UIFont systemFontOfSize:16];
    UserName.textColor = [UIColor whiteColor];
    [scroll addSubview:UserName];
    
    email =[[UITextField alloc] initWithFrame:CGRectMake(70, 185, 185, 30)];
    email.placeholder = @"请输入一个邮箱";
    email.delegate = self;
    email.returnKeyType = UIReturnKeyNext;
    email.font =[UIFont systemFontOfSize:16];
    email.textColor = [UIColor whiteColor];
    [scroll addSubview:email];
    
    
    Password = [[UITextField alloc] initWithFrame:CGRectMake(70, 265, 185, 30)];
    Password.placeholder = @"请输入6-20位密码";
    Password.delegate =self;
    Password.returnKeyType = UIReturnKeyNext;
    Password.secureTextEntry = YES;
    Password.font = [UIFont systemFontOfSize:16];
    Password.textColor = [UIColor whiteColor];
    [scroll addSubview:Password];

    UIButton * submmit = [UIButton buttonWithType:0];
    submmit.frame = CGRectMake(100, 350, 130, 40);
    submmit.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reg_commit.png"]];
    [submmit addTarget:self action:@selector(reg) forControlEvents:
     UIControlEventTouchUpInside];
    [scroll addSubview:submmit];
    
    
}

-(void)choose:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            [self showTabBar];
            [self.navigationController popViewControllerAnimated:YES];
     
        }
            break;
        case 3:
            
            break;

        default:
            break;
    }
    
}


-(void)reg
{

    NSString *msg=@"ok";
    
    [UserName endEditing:YES];

    if(UserName.text.length==0)
    {
        msg=@"请输入用户名";
        
    }else if(UserName.text.length<6||UserName.text.length>15)
    {
        msg=@"请输入6~15个字符";
    }
    else if(Password.text.length==0)
    {
        msg=@"请输入密码";
    }
    else if(Password.text.length<6||Password.text.length>20)
    {
        msg=@"请输入6－20位密码";
    }else if (email.text.length == 0)
    {
        msg=@"请输入您的邮箱";
    }
    
    if ([msg isEqualToString:@"ok"]) {
       
        //zhuce
        mb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mb.labelText = @"注册中...";

        NSDictionary * dic =[[NSDictionary alloc] initWithObjectsAndKeys:UserName.text,@"user[username]",Password.text,@"user[password]",email.text,@"user[email]", nil];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:[NSString stringWithFormat:@"http://42.120.9.87:4010/api/users/"] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [mb hide:YES];
            NSDictionary * res =[[NSDictionary alloc] init];
            res = responseObject;
            NSLog(@"res =%@",responseObject);
            [[NSUserDefaults standardUserDefaults] setObject:UserName.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:UserName.text forKey:@"username"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"注册成功"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
            [self showTabBar];
            [self.navigationController popViewControllerAnimated:YES];

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [mb hide:YES];
            NSLog(@"error=%@",error);
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"注册失败"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    
}


- (void)upLoad
{
//    NSLog(@"touxiang");
    UIActionSheet *sheet =[[UIActionSheet alloc]initWithTitle:@"选择图片来源" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择",@"摄像头拍摄",@"取消", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                
                UIImagePickerController *imgPicker = [UIImagePickerController new];
                imgPicker.delegate = self;
                imgPicker.allowsEditing= YES;
                imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imgPicker animated:YES completion:nil];
                return;
            }
            else {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"该设备没有摄像头"
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"好", nil];
                [alertView show];
                
            }
            
        }
            break;
        case 0:
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }
            break;
        case 2:
            
            break;
        default:
            break;
    }
    
}



//隐藏键盘
-(void)textFieldEditing
{
    [UserName resignFirstResponder];
    [Password resignFirstResponder];
    [email resignFirstResponder];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField == UserName) {
        [email becomeFirstResponder];
    }else if (textField == email)
        [Password becomeFirstResponder];
     
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == UserName) {
        //        [scroll setContentOffset:CGPointMake(0, 20) animated:YES];
    }else if (textField == email)
        [scroll setContentOffset:CGPointMake(0, 100) animated:YES];
    else if (textField == Password)
        [scroll setContentOffset:CGPointMake(0, 150) animated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //        NSLog(@"yincangjianpan");
    [textField resignFirstResponder];
    [scroll setContentOffset:CGPointMake(0, -20) animated:YES];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
