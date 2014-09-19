//
//  M_messageViewController.m
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_messageViewController.h"
#import "M_examViewController.h"

@interface M_messageViewController ()<UIAlertViewDelegate,UIActionSheetDelegate,UITextViewDelegate>
{
    UITextView * textView;
    NSString * liuyanStr;
}
@end

@implementation M_messageViewController

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
    [self drawNav];
    [self drawView];
//
    
  
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
    title.text = @"航空学校";
    title.font = [UIFont boldSystemFontOfSize:18.f];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [view addSubview:title];
    
//    UIButton *homeBt =[[UIButton alloc] initWithFrame:CGRectMake(13, 10, 30 , 30)];
//    [homeBt setImage:[UIImage imageNamed:@"public_home.png"] forState:UIControlStateNormal];
//    homeBt.tag =1;
//    [homeBt addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:homeBt];
    
    UIButton *rButton =[[UIButton alloc] init];
    rButton =[UIButton buttonWithType:0];
    [rButton setImage:[UIImage imageNamed:@"topR.png"] forState:UIControlStateNormal];
    [rButton setFrame:CGRectMake(275, 10, 30, 30)];
    rButton.tag = 2;
    [rButton addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rButton];
    
}


-(void)drawView
{
    UITextView * textF = [[UITextView alloc] initWithFrame:CGRectMake(5, 79, 310, self.view.frame.size.height-79+49)];
    textF.text = @"目前私照学习，国内大约有16家航空学校具体想了解可以联系：school@mfeiji.com我们会在下一版本更新中提供更详细的航校情况，敬请期待！";
    textF.delegate =self;
    textF.backgroundColor = [UIColor clearColor];
    textF.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textF];
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

-(void)choose:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
//            M_examViewController * exam = [[M_examViewController alloc] init];
//            [self.navigationController  pushViewController:exam animated:NO];
        }
            break;
        case 2:
        {
            UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享到微信好友",@"分享到朋友圈", nil];
            [sheet showInView:self.view];
        }
            
            break;
            
            
        default:
            break;
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



@end
