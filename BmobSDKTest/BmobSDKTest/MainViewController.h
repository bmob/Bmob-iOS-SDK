//
//  MainViewController.h
//  BmobSDKDemo
//
//  Created by Bmob on 13-11-28.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSCoding,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    
    NSMutableArray            *dataArray;
    
}


@property(nonatomic,retain) NSString *testCode;

@end
