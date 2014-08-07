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
    UIImageView *headView;
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
    topView.image = [UIImage imageNamed:@"my_baidi.png"];
    [topView setUserInteractionEnabled:YES];
    [self.view addSubview:topView];

    headView = [[UIImageView alloc]initWithFrame:CGRectMake(18, 113, 50, 50)];
    headView.image = [UIImage imageNamed:@"public_head.png"];
    headView.userInteractionEnabled = YES;
    [self.view addSubview:headView];
    UITapGestureRecognizer *pass = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(upLoad)];
    [headView addGestureRecognizer:pass];
    
    UIButton *changeBt =[[UIButton alloc] init];
    changeBt =[UIButton buttonWithType:0];
    [changeBt setImage:[UIImage imageNamed:@"my_xiugai.png"] forState:UIControlStateNormal];
    [changeBt setFrame:CGRectMake(100, 130, 60, 15)];
    [changeBt addTarget:self action:@selector(upLoad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBt];
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
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 39.5, 300,0.5)];
    line.backgroundColor=[UIColor colorWithRed:0.7 green:0.7 blue:0.77 alpha:1];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [cell addSubview:line];
    
    NSInteger row = [indexPath row];
    cell.textLabel.text =[nameArr objectAtIndex:row];

    return cell;
    
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
    
}

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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
