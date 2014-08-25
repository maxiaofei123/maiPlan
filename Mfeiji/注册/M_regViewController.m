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
    view = [[UIView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lanDi.png"]];
    [scroll addSubview:view];
    
    
    UILabel *title;
    title = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, view.frame.size.width-120, 44)];
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
    UserName.placeholder = @"请输入用户名";
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
    

    //验证
    
//    UILabel *test = [[UILabel alloc] initWithFrame:CGRectMake(180, 320, 160, 30)];
//    test.text =@"输入11位手机号";
//    [scroll addSubview:test];
//    
//    UIImageView *numberView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 320, 130, 40)];
//    numberView.backgroundColor = [UIColor grayColor];
//    [numberView setUserInteractionEnabled:YES];
//    [scroll addSubview:numberView];
//    
//    phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, 125, 30)];
//    phoneNumber.textColor = [UIColor blackColor];
//    phoneNumber.placeholder = @"请输入手机号码";
//    phoneNumber.delegate =self;
//    phoneNumber.secureTextEntry = YES;
//    phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
//    [numberView addSubview:phoneNumber];
//    //验证码
//    UIImageView *getView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 390, 130, 40)];
//    getView.backgroundColor = [UIColor grayColor];
//    [getView setUserInteractionEnabled:YES];
//    [scroll addSubview:getView];
//    
//    verCode = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, 120, 30)];
//    verCode.textColor = [UIColor blackColor];
//    verCode.placeholder = @"请输入验证码";
//    verCode.delegate =self;
//    verCode.returnKeyType = UIReturnKeyDone;
//    [getView addSubview:verCode];
//    
//    getVer = [UIButton buttonWithType:0];
//    [getVer setFrame:CGRectMake(180, 390, 97, 40)];
//    [getVer setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [getVer setTitleColor:[UIColor colorWithRed:170/255. green:194/255. blue:201/255. alpha:1.] forState:UIControlStateNormal];
//    getVer.backgroundColor = [UIColor whiteColor];
//    getVer.titleLabel.font = [UIFont systemFontOfSize:13.];
//    [getVer addTarget:self action:@selector(reSend) forControlEvents:UIControlEventTouchUpInside];
//    [scroll addSubview:getVer];
    //提交按钮
    
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
            
            M_examViewController * exam = [[M_examViewController alloc] init];
            [self.navigationController pushViewController:exam animated:YES];
            
        }
            break;
        case 3:
            
            break;

        default:
            break;
    }
    
}

//发送验证码
/*-(void)reSend
{
    
    [UserName resignFirstResponder];
    [Password resignFirstResponder];
    [phoneNumber resignFirstResponder];
    [confirmPassword resignFirstResponder];
    [verCode resignFirstResponder];
    
    NSString *phone = [phoneNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length == 0 || phone.length != 11) {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:@"提示" message:@"手机号码为空或不符合规定，请填写正确的手机号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alt show];
        return;
    }
    else{
        //发送请求
        getVer.enabled = NO;
        [self timeFireMethod];
    }
  
}*/

-(void)reg
{

    NSString *msg=@"ok";
    
    [UserName endEditing:YES];

    if(UserName.text.length==0)
    {
        msg=@"请输入用户名";
    }    else if(Password.text.length==0)
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

#pragma 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    NSData *data;
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //图片压缩，因为原图都是很大的，不必要传原图
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
        
        //以下这两步都是比较耗时的操作，最好开一个HUD提示用户，这样体验会好些，不至于阻塞界面
        if (UIImagePNGRepresentation(scaleImage) == nil) {
            //将图片转换为JPG格式的二进制数据
            data = UIImageJPEGRepresentation(scaleImage, 1);
        } else {
            //将图片转换为PNG格式的二进制数据
            data = UIImagePNGRepresentation(scaleImage);
        }
        
        //        //将二进制数据生成UIImage
        //        UIImage *image = [UIImage imageWithData:data];
        //
        //        //将图片传递给截取界面进行截取并设置回调方法（协议）
        //        headView.image = image;
        //        //隐藏UIImagePickerController本身的导航栏
        //        image.navigationBar.hidden = YES;
        //        [picker pushViewController:captureView animated:YES];
        
    }
}

#pragma mark - 图片回传协议方法
-(void)passImage:(UIImage *)image
{
    headView.image = image;
}

#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


//获取验证码倒计时
-(void)timeFireMethod{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                getVer.titleLabel.text = @"重新获取";
                getVer.titleLabel.textAlignment = NSTextAlignmentCenter;
                getVer.enabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d秒", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                getVer.titleLabel.text = strTime;
                getVer.titleLabel.textAlignment = NSTextAlignmentCenter;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
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
