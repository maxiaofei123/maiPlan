//
//  M_public.m
//  Mfeiji
//
//  Created by susu on 14-8-5.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import "M_public.h"
#import "CommonCrypto/CommonDigest.h"

@implementation M_public


+ (void)sendLinkContent:(int)type
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"助力中国和人飞行，成就国人放飞梦想.";
        message.description = @"助力中国和人飞行，成就国人放飞梦想。";
        [message setThumbImage:[UIImage imageNamed:@"120-120.png"]];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = [NSString stringWithFormat:@"%@",@"https://itunes.apple.com/us/app/mai-fei-ji/id920281189?l=zh&ls=1&mt=8"];
        
        message.mediaObject = ext;
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        if (type == 0) {
            req.scene = WXSceneSession;
        }else
            req.scene = WXSceneTimeline;
        
        [WXApi sendReq:req];
    }else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你的iPhone上还没有安装微信,无法使用此功能，去下载微信。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"免费下载微信", nil];
        alView.tag = 100;
        [alView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100){
        if (buttonIndex == 1) {
            NSString *weiXinLink = @"itms-apps://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weiXinLink]];
        }
    }
}



@end
