//
//  M_selfViewController.h
//  Mfeiji
//
//  Created by susu on 14-7-19.
//  Copyright (c) 2014年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface M_selfViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
  

}

@property (strong ,nonatomic)UITableView * MtableView;
@property (strong ,nonatomic)NSString * granderStr;

@end
