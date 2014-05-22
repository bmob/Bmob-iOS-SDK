//
//  CreateTableViewController.m
//  BmobSDKTest
//
//  Created by Bmob on 13-8-8.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import "CreateTableViewController.h"
#import <BmobSDK/BmobObject.h>
#import <BmobSDK/BmobFile.h>//"BmobFile.h"
#import "MBProgressHUD.h"
#import <BmobSDK/BmobGeoPoint.h>//"BmobGeoPoint.h"
#import <BmobSDK/BmobUser.h>

@interface CreateTableViewController ()

@end

@implementation CreateTableViewController

#define kMBProgressHUD   9900

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
	// Do any additional setup after loading the view.
    
    self.title = @"创建表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [navRightBtn setFrame:CGRectMake(0, 0, 50, 40)];
    [navRightBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [navRightBtn addTarget:self action:@selector(create) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:navRightBtn] autorelease];
    
    

    
    
    UITextField  *proUTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 70, 200, 30)];
    proUTF.placeholder = @"playerName";
    proUTF.backgroundColor = [UIColor whiteColor];
    proUTF.tag = 101;
    [self.view addSubview:proUTF];
    [proUTF release];
    
    
    UITextField  *valueUTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, 200, 30)];
    valueUTF.placeholder = @"score";
    valueUTF.tag = 102;
    valueUTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:valueUTF];
    [valueUTF release];
    
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.tag = kMBProgressHUD;
    [self.navigationController.view addSubview:hud];
    
    [hud release];
}


-(void)create{

    UITextField *proUTF = (UITextField*)[self.view viewWithTag:101];
    UITextField *valueUTF = (UITextField*)[self.view viewWithTag:102];
    


    BmobObject *gameScore = [BmobObject objectWithClassName:@"GameScore"];
    [gameScore incrementKey:@"score"];
    
    [gameScore setObject:proUTF.text forKey:@"playerName"];
    [gameScore setObject:[NSNumber numberWithInt: [valueUTF.text intValue]] forKey:@"score"];
    [gameScore setObject:[NSNumber numberWithInt:(unsigned int)arc4random()%5] forKey:@"class"];
    [gameScore setObject:@[@"语文",@"数学",@"英语"] forKey:@"course"];
    [gameScore setObject:@{@"语文": @89} forKey:@"aveScore"];
    [gameScore setObject:[[[BmobGeoPoint alloc] initWithLongitude:22.3333 WithLatitude:33.2222] autorelease] forKey:@"lastLocation"];
    [gameScore setObject:[BmobUser objectWithoutDatatWithClassName:nil objectId:@"25fb9b4a61"] forKey:@"name"];
    
    
    
    MBProgressHUD *hud = (MBProgressHUD*)[self.navigationController.view viewWithTag:kMBProgressHUD];
    hud.labelText = @"创建中";
    [hud show:true];
    [hud hide:YES afterDelay:15.5f];
    
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        
        NSLog(@"error %@",[error description]);
        if (isSuccessful) {
            
            hud.labelText = @"创建成功！";
            [hud hide:YES afterDelay:0.5f];
        }
        else{
            hud.labelText = @"创建失败！";
            [hud hide:YES afterDelay:0.5f];
        }
        
    }];
    
//    [gameScore saveInBackground];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
