//
//  M_selfViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_selfViewController.h"
#import "ImageSizeManager.h"
#import "UIImageView+WebCache.h"
#import "ASIFormDataRequest.h"
#import "UIImageView+WebCache.h"



@interface M_selfViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    NSArray *nameArr;
    UIImageView *headView;
    UIImage * linshiImage;
    
    NSMutableArray *textFileArr;
    int textId;
    
    NSMutableDictionary * tefileDic;
    
    UITextField *nameText;
    UITextField *phoneText;
    UITextField *schoolText;
    UILabel *granderlable;
    
    
    UILabel * scoreLable;
    NSString * scorestr;
    
    MBProgressHUD *mb;
    
    int will;
    ASIFormDataRequest *request;

//性别
    UIButton *btnan;
    UIButton * btNv;
    UIView * viewSex;
    int sexTag;
    NSString * genderStr;
    int reloadTag;

}

@end

@implementation M_selfViewController
@synthesize MtableView,granderStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated

{   if(will == 10)
    {
        [self requst];
    }
    will = 10;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     will =9;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height-20)];
    view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"hui_bg.png"]];
    [self.view addSubview:view];
    textId =0;
    sexTag =101;
    reloadTag =0;
    
    
    nameArr = [[NSArray alloc] initWithObjects:@"昵称:",@"性别:",@"手机:",@"航校:", nil];
    textFileArr = [[NSMutableArray alloc] init];
    
    MtableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 64, 300, self.view.frame.size.height-100-64)style:UITableViewStyleGrouped];
    
    MtableView.delegate =self;
    MtableView.dataSource =self;
    MtableView.backgroundColor = [UIColor clearColor];
    MtableView.scrollEnabled = YES;
    MtableView.showsVerticalScrollIndicator =NO;
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
  if ([[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"] ==NULL) {
      
    }else{

        NSLog(@"user user user");
        NSString * nameStr = [NSString stringWithFormat:@"%@",[tefileDic objectForKey:@"username"]];
        NSString * phoneStr =[NSString stringWithFormat:@"%@",[tefileDic objectForKey:@"phone"]];
        genderStr =[NSString stringWithFormat:@"%@",[tefileDic objectForKey:@"gender"]];
        NSString * schoolStr =[NSString stringWithFormat:@"%@",[tefileDic objectForKey:@"school_name"]];
        scorestr =[NSString stringWithFormat:@"%@",[tefileDic objectForKey:@"topscore"]];
        
        
        NSLog(@"name =%@ phone =%@  grander =%@ school=%@ score=%@",nameStr,phoneStr,genderStr,schoolStr,schoolStr);
        if (!([nameStr isEqualToString:@"<null>"])) {
            nameText.text = nameStr;
        }
        if (!([genderStr isEqualToString:@"<null>"])) {
            granderlable.text = genderStr;
        }
        if (!([phoneStr isEqualToString:@"<null>"])) {
            phoneText.text = phoneStr;
        }
        if (!([schoolStr isEqualToString:@"<null>"])) {
            schoolText.text = schoolStr;
            
        }
        if([scorestr isEqualToString:@"<null>"] || scorestr.length ==0)
        {
        
        }else{
            
            scoreLable.text =[NSString stringWithFormat:@"%@  分",scorestr];
        }
    }
}

-(void)requst
{
    NSString * auth = [[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"];
    if (auth.length > 0) {
        NSString *str =[[NSString alloc] initWithFormat:@"http://42.120.9.87:4010/api/users/profile?auth_token=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"]];
            
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
               NSDictionary * dic=responseObject;
                tefileDic = [NSMutableDictionary alloc];
                 tefileDic =[dic objectForKey:@"user"];
                // 设置头像
                NSString *imageUrl = [NSString stringWithFormat:@"%@",[[[tefileDic objectForKey:@"avatar"] objectForKey:@"thumb"] objectForKey:@"url"]];
                [[NSUserDefaults standardUserDefaults] setObject:imageUrl forKey:@"imageUrl"];
                
                if (imageUrl.length > 0) {
                    
                    [headView setImageWithURL:[NSURL URLWithString:imageUrl]];
                }
                NSLog(@"imageurl = %@ ",imageUrl);
                
                //一个cell刷新
                reloadTag =1;
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
                [MtableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                //显示个人信息
                [self setTextFile];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"获取信息失败，请检查网络"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                nameText.text = nil;
                phoneText.text =nil;
                schoolText.text = nil;
            }];
    }else{
    
    }
}

-(void)commitUser
{
  
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"] == NULL) {
        nameText.text = nil;
        phoneText.text =nil;
        schoolText.text = nil;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"您还没有登陆，请先登陆"
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];

    }else{
        if (!(phoneText.text.length == 0 || phoneText.text.length ==11)) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"请输入11位号码"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
        }else{
            
           // asi 上传修改信息
            mb = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            mb.labelText = @"提交资料中...";
            NSString * userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
            NSString *sex = [[NSString alloc] init];
            if (sexTag == 0) {
                sex =@"男";
            }
            else if(sexTag == 1)
            {
                sex =@"女";
            }else
            {
                sex =genderStr;
            }
            NSLog(@"sex =%@",sex);
            NSString  * s =[NSString stringWithFormat:@"http://42.120.9.87:4010/api/users/%@?auth_token=%@",userId,[[NSUserDefaults standardUserDefaults]objectForKey:@"auth_token"]];
            NSLog(@"str =%@",s);
            NSURL *url = [NSURL URLWithString:[s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            request = [ASIFormDataRequest requestWithURL:url];
            
            NSData *mData = UIImageJPEGRepresentation(headView.image, 1);
            
            [request  addData:mData  withFileName:@"avatarImage.png" andContentType:@"image/JPEG"  forKey:@"user[avatar]"];
            [request setPostValue:nameText.text forKey:@"user[username]"];
            [request setPostValue:sex forKey:@"user[gender]"];
            [request setPostValue:phoneText.text forKey:@"user[phone]"];
            [request setPostValue:schoolText.text forKey:@"user[school_name]"];
            [request setDelegate:self];
            [request setRequestMethod:@"PUT"];
            request.timeOutSeconds=60;
            [request startAsynchronous];
            
        }
    }
}

- (void)requestFinished:(ASIHTTPRequest *)r
{
     mb.labelText = @"提交成功";
    [mb hide:YES afterDelay:1];
    NSData *jsonData = [r responseData];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    //清楚之前的图片缓存
    NSString * key = [[NSUserDefaults standardUserDefaults]objectForKey:@"imageUrl"];
//    [[SDImageCache sharedImageCache] removeImageForKey:key];
    [[SDImageCache sharedImageCache] cleanDisk];
    
//    NSLog(@"requstFinished=%@",jsonObject);
    
}
- (void)requestFailed:(ASIHTTPRequest *)r
{
    [mb hide:YES];
    NSError *error = [r error];
    NSLog(@"profile_vatar:%@",error);
}


-(void)textFieldEditing
{
    [nameText resignFirstResponder];
    [phoneText resignFirstResponder];
    [schoolText resignFirstResponder];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   if (textField == phoneText)
    {
        [MtableView setContentOffset:CGPointMake(0, 124) animated:YES];

    }
    else if (textField ==schoolText)
    {
        [MtableView setContentOffset:CGPointMake(0, 164) animated:YES];

    }
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    [MtableView setContentOffset:CGPointMake(0, 0) animated:YES];

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
    title.text = @"我的个人主页";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
}

-(void)chooseSex:(UIButton *)sender
{
   if(sender.tag ==201)
   {
       [btnan setBackgroundImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
       [btNv setBackgroundImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
       sexTag = 0;
   }else if (sender.tag =202)
   {
       [btNv setBackgroundImage:[UIImage imageNamed:@"choose.png"] forState:UIControlStateNormal];
       [btnan setBackgroundImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
       sexTag = 1;
   
   }

}

#pragma mark -tableview

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *tableSampleIdentifier = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    if (cell ==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }
    else
    {
        [cell removeFromSuperview];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];

    
    }
    
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];//取消cell点击效果

   NSInteger row = [indexPath row];
    switch (indexPath.section) {
        case 0:
        {
            UIImageView * hImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 50, 50)];
            hImage.image =[UIImage imageNamed:@"public_head.png"];
            [cell addSubview:hImage];
            hImage.userInteractionEnabled =YES;
            UITapGestureRecognizer *pass1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upLoad)];
            [hImage addGestureRecognizer:pass1];
            
            headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            headView.userInteractionEnabled = YES;
            [hImage addSubview:headView];
            UITapGestureRecognizer *pass = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upLoad)];
            [headView addGestureRecognizer:pass];
            
            if (linshiImage == nil) {
                
                [headView setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"imageUrl"]]];
            }else
            {
                headView.image = linshiImage;
            }

            
            UIButton *changeBt =[[UIButton alloc] init];
            changeBt =[UIButton buttonWithType:0];
            [changeBt setImage:[UIImage imageNamed:@"my_xiugaitouxiang.png"] forState:UIControlStateNormal];
            [changeBt setFrame:CGRectMake(100, 22, 60, 15)];
            [changeBt addTarget:self action:@selector(upLoad) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:changeBt];

        }
            break;
        case 1:
        {
            cell.textLabel.text =[nameArr objectAtIndex:row];
            
            if (indexPath.row ==0) {
                nameText = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 150, 30)];
                nameText.textColor = [UIColor blackColor];
                nameText.font =[UIFont systemFontOfSize:16];
                nameText.tag = indexPath.row;
                nameText.delegate =self;
                [cell addSubview:nameText];
            }else if(indexPath.row ==1)
            {
                NSLog(@"reloadTag =%d",reloadTag);
                if (reloadTag ==1) {
                    
                    NSString * sex = [NSString stringWithFormat:@"%@",[tefileDic objectForKey:@"gender"]];
//                    NSLog(@"gender =%@",sex);
//                     NSLog(@"sex,lenght =%d",sex.length);
                    if (sex.length <1 || [sex isEqualToString:@"<null>"]) {
                        
                        viewSex = [[UIView alloc] initWithFrame:CGRectMake(60, 0.5, 160, 38)];
                        viewSex.backgroundColor = [UIColor whiteColor];
                        [cell addSubview:viewSex];
                        
                        btnan =[[UIButton alloc] initWithFrame:CGRectMake(50, 10, 20, 20)];
                        [btnan setBackgroundImage:[UIImage imageNamed:@"yuan.png"] forState:UIControlStateNormal];
                        btnan.tag = 201;
                        [btnan addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
                        [viewSex addSubview:btnan];
                        
                        btNv =[[UIButton alloc] initWithFrame:CGRectMake(140, 10, 20, 20)];
                        [btNv setBackgroundImage:[UIImage imageNamed:@"yuan"] forState:UIControlStateNormal];
                        btNv.tag =202;
                        [btNv addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
                        [viewSex addSubview:btNv];
                        
                        
                        UIButton *nan = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
                        [nan setTitle:@"男" forState:UIControlStateNormal];
                        [nan  setTitle:@"男" forState:UIControlStateSelected];
                        [nan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [nan setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                        [viewSex addSubview:nan];
                        
                        UIButton *nv = [[UIButton alloc] initWithFrame:CGRectMake(100, 5, 30, 30)];
                        [nv setTitle:@"女" forState:UIControlStateNormal];
                        [nv setTitle:@"女" forState:UIControlStateSelected];
                        [nv setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [nv setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                        [viewSex addSubview:nv];

                    }else
                    {
                        [viewSex removeFromSuperview];
                        granderlable = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 30, 30)];
                        granderlable.textColor = [UIColor blackColor];
                        granderlable.text = genderStr;
                        granderlable.font = [UIFont systemFontOfSize:18];
                        [cell addSubview:granderlable];
                    }
                    
                    reloadTag == 0;
                    
                }
                
            }
            else if(indexPath.row ==2)
            {
                phoneText = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 150, 30)];
                phoneText.textColor = [UIColor blackColor];
                phoneText.font =[UIFont systemFontOfSize:16];
                phoneText.keyboardType = UIKeyboardTypeNumberPad;
                phoneText.tag = indexPath.row;
                phoneText.delegate =self;
                [cell addSubview:phoneText];
            }
            else if(indexPath.row ==3)
            {
                schoolText = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, 150, 30)];
                schoolText.textColor = [UIColor blackColor];
                schoolText.font =[UIFont systemFontOfSize:16];
                schoolText.tag = indexPath.row;
                schoolText.delegate =self;
                [cell addSubview:schoolText];
            }

        }
            break;
        case 2:
        {
            cell.textLabel.text =@"私照理论 :";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            scoreLable = [[UILabel  alloc] initWithFrame:CGRectMake(110, 16, 200, 30)];
            scoreLable.textColor =[UIColor redColor];
            if([scorestr isEqualToString:@"<null>"] || scorestr.length ==0)
            {
                
            }else{
                
                scoreLable.text =[NSString stringWithFormat:@"%@  分",scorestr];
            }

            scoreLable.font = [UIFont systemFontOfSize:16];
            [cell addSubview:scoreLable];
        }
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
    linshiImage = [ImageSizeManager getMaxImageWithOldImage:info[UIImagePickerControllerEditedImage]];
 
    [picker dismissViewControllerAnimated:YES completion:^{
       headView.image = linshiImage;
     
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
