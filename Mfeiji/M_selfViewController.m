//
//  M_selfViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_selfViewController.h"
#import "self_setPageViewController.h"
#import "ImageSizeManager.h"

@interface M_selfViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    NSArray *nameArr;
    UIImageView *headView;
    
    NSMutableArray *textFileArr;
    int textId;
    
    NSMutableDictionary * tefileDic;
    
    UITextField *nameText;
    UITextField *granderText;
    UITextField *phoneText;
    UITextField *schoolText;
    
    MBProgressHUD *mb;
    
 
}

@end

@implementation M_selfViewController
@synthesize MtableView;

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
    textId =0;
    nameArr = [[NSArray alloc] initWithObjects:@"昵称:",@"性别:",@"手机:",@"航校:", nil];
    textFileArr = [[NSMutableArray alloc] init];
    
    MtableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 64, 300, self.view.frame.size.height-100-64)style:UITableViewStyleGrouped];
    
    MtableView.delegate =self;
    MtableView.dataSource =self;
    MtableView.backgroundColor = [UIColor clearColor];
    MtableView.scrollEnabled = NO;
    [self.view addSubview:MtableView];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.MtableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    UITapGestureRecognizer *textFeild = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textFieldEditing)];
    [MtableView addGestureRecognizer:textFeild];
    
    UIButton *commit =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [commit setFrame:CGRectMake((self.view.frame.size.width-100)/2, self.view.frame.size.height-44-40, 100, 30)];
    [commit setTitle:@"保存修改" forState:UIControlStateNormal];
    [commit setTitle:@"保存修改" forState:UIControlStateSelected];
    [commit setBackgroundColor:[UIColor colorWithRed:201/255. green:201/255. blue:201/255. alpha:1.]];
    [commit setTintColor:[UIColor whiteColor]];
    [commit.layer setCornerRadius:8.0];
    commit.titleLabel.font = [UIFont systemFontOfSize:14.];
    [commit addTarget:self action:@selector(commitUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commit];
    

    [self drawNav];
    [self requst];
    

}
-(void)setTextFile
{
    NSLog(@"user user user");
    nameText.text = [tefileDic objectForKey:@"username"];
    NSString * phoneStr =[NSString stringWithString:[tefileDic objectForKey:@"phone"]];
    NSString * genderStr =[NSString stringWithString:[tefileDic objectForKey:@"gender"]];
    NSString * schoolStr =[NSString stringWithString:[tefileDic objectForKey:@"school_name"]];
    
    if (genderStr.length > 0) {
        granderText.text = genderStr;
    }
    if (genderStr.length > 0) {
        phoneText.text = phoneStr;
    }
    if (genderStr.length > 0) {
        schoolText.text = schoolStr;

    }
}

-(void)requst
{
    NSString *str =[[NSString alloc] initWithFormat:@"http://42.120.9.87:4010/api/users/profile?auth_token=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       NSDictionary * dic=responseObject;
        tefileDic = [dic objectForKey:@"user"];
        NSLog(@"%@",tefileDic);
        
        [self setTextFile];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
    
}

-(void)commitUser
{
    if (!(phoneText.text.length == 0 || phoneText.text.length ==11)) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"请输入11位号码"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }else{
        mb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        mb.labelText = @"提交资料中...";

        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys: nameText.text,@"user[username]",granderText.text,@"user[gender]",phoneText.text,@"user[phone]",schoolText.text,@"user[school_name]", UIImageJPEGRepresentation(headView.image, 1.0),@"user[avatar]",nil];
        

//        NSLog(@"dic =%@  %@",dic ,[NSString stringWithFormat:@"http://42.120.9.87:4010/api/users/auth_token=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"]]);

        NSString * userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager PUT:[NSString stringWithFormat:@"http://42.120.9.87:4010/api/users/%@?auth_token=%@",userId,[[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"]] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
//            NSLog(@"修改成功 ,%@",responseObject);
            mb.labelText = @"修改成功";
            [mb hide:YES afterDelay:2];
            
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                        message:@"保存失败,请检查网络"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
        }];
    }

}


-(void)textFieldEditing
{
    [nameText resignFirstResponder];
    [granderText resignFirstResponder];
    [phoneText resignFirstResponder];
    [schoolText resignFirstResponder];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == nameText) {
        [MtableView setContentOffset:CGPointMake(0, 44) animated:YES];
    }
    if (textField == granderText) {
        [MtableView setContentOffset:CGPointMake(0, 84) animated:YES];
    }else if (textField == phoneText)
        [MtableView setContentOffset:CGPointMake(0, 124) animated:YES];
    else if (textField ==schoolText)
        [MtableView setContentOffset:CGPointMake(0, 164) animated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    [MtableView setContentOffset:CGPointMake(0, 0) animated:YES];
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


#pragma mark -tableview

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
        
    }
    
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];//取消cell点击效果

   NSInteger row = [indexPath row];
    switch (indexPath.section) {
        case 0:
        {
            headView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 5, 50, 50)];
            headView.image = [UIImage imageNamed:@"public_head.png"];
            headView.userInteractionEnabled = YES;
            [cell addSubview:headView];
            
            UITapGestureRecognizer *pass = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upLoad)];
            [headView addGestureRecognizer:pass];
            
            UIButton *changeBt =[[UIButton alloc] init];
            changeBt =[UIButton buttonWithType:0];
            [changeBt setImage:[UIImage imageNamed:@"my_xiugai.png"] forState:UIControlStateNormal];
            [changeBt setFrame:CGRectMake(100, 22, 60, 15)];
            [changeBt addTarget:self action:@selector(upLoad) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:changeBt];

        }
            break;
        case 1:
        {
            cell.textLabel.text =[nameArr objectAtIndex:row];
            
            if (indexPath.row ==0) {
                nameText = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 200, 30)];
                nameText.textColor = [UIColor blackColor];
                nameText.font =[UIFont systemFontOfSize:16];
                nameText.tag = indexPath.row;
                nameText.delegate =self;
                [cell addSubview:nameText];
            }else if(indexPath.row ==1)
            {
                granderText = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 200, 30)];
                granderText.textColor = [UIColor blackColor];
                granderText.font =[UIFont systemFontOfSize:16];
                granderText.tag = indexPath.row;
                granderText.delegate =self;
                [cell addSubview:granderText];
            }
            else if(indexPath.row ==2)
            {
                phoneText = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 200, 30)];
                phoneText.textColor = [UIColor blackColor];
                phoneText.font =[UIFont systemFontOfSize:16];
                phoneText.keyboardType = UIKeyboardTypeNumberPad;
                phoneText.tag = indexPath.row;
                phoneText.delegate =self;
                [cell addSubview:phoneText];
            }
            else if(indexPath.row ==3)
            {
                schoolText = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 200, 30)];
                schoolText.textColor = [UIColor blackColor];
                schoolText.font =[UIFont systemFontOfSize:16];
                schoolText.tag = indexPath.row;
                schoolText.delegate =self;
                [cell addSubview:schoolText];
            }

            
        }
            break;
        case 2:
            cell.textLabel.text =@"私照理论 :";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            break;
            
        default:
            break;
    }
    
    
    return cell;
    
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return 60;
    else if(indexPath.section == 1)
    return 40.0f;
    else if(indexPath.section ==2)
        return 60;
    
    return 40;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0 ||section ==2) {
        return 1;
    }else if(section ==1){
        return 4;
    }

    return 4;
    
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 38)];
    if (section == 2) {
        headerLabel.text = @"最高成绩";
    }
    
    [headerLabel setFont:[UIFont systemFontOfSize:16.0]];
    [headerLabel setTextColor:[UIColor blackColor]];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    return headerLabel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


#pragma mark -upPhoto

//  选择头像来源
- (void)upLoad
{
    NSLog(@"touxiang");
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image2 = [ImageSizeManager getMaxImageWithOldImage:info[UIImagePickerControllerEditedImage]];
    [picker dismissViewControllerAnimated:YES completion:^{
        headView.image = image2;
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
