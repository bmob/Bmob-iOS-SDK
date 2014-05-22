//
//  SignUpViewController.m
//  BmobSDKTest
//
//  Created by Bmob on 13-8-8.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import "SignUpViewController.h"
#import <BmobSDK/BmobUser.h>//"BmobUser.h"
#import "MBProgressHUD.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [navRightBtn setFrame:CGRectMake(0, 0, 50, 40)];
    [navRightBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [navRightBtn addTarget:self action:@selector(testUser) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:navRightBtn] autorelease];
    
    
    UITextField  *tableNameUTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 20+50, 100, 30)];
    tableNameUTF.backgroundColor = [UIColor whiteColor];
    tableNameUTF.placeholder = @"用户名";
    tableNameUTF.tag = 100;
    [self.view addSubview:tableNameUTF];
    [tableNameUTF release];
    
    
    UITextField  *proUTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 70+50, 100, 30)];
    proUTF.placeholder = @"密码";
    proUTF.secureTextEntry = YES;
    proUTF.backgroundColor = [UIColor whiteColor];
    proUTF.tag = 101;
    [self.view addSubview:proUTF];
    [proUTF release];
    
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.tag = kMBProgressHUD;
    [self.navigationController.view addSubview:hud];
    
    [hud release];
}


-(void)testUser{
    
    [self signupWithType:0];
    
//    [self signupWithType:1];
    
}


- (void)signupWithType:(NSInteger)type{
    
    UITextField *userUTF = (UITextField*)[self.view viewWithTag:100];
    UITextField *passwordUTF = (UITextField*)[self.view viewWithTag:101];
    
    BmobUser *bUser  = [[BmobUser alloc] init];
    [bUser setUserName:[NSString stringWithFormat:@"%@%d",userUTF.text ,(unsigned int)arc4random()%10]];
    [bUser setPassword:passwordUTF.text];
    [bUser setObject:@[@4,@5,@6] forKey:@"num"];
    if (type == 0) {
        [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
            
            
            BmobUser    *user = [BmobUser getCurrentUser];
            
            NSLog(@"getCurrentUser num %@",[user objectForKey:@"num"]);
            
            MBProgressHUD *hud = (MBProgressHUD*)[self.navigationController.view viewWithTag:kMBProgressHUD];
            hud.labelText = @"注册中";
            [hud show:true];
            [hud hide:YES afterDelay:15.5f];
            if (isSuccessful) {
                hud.labelText = @"注册成功！";
                [hud hide:YES afterDelay:0.5f];
            }
            else{
                
                hud.labelText = [[error userInfo] objectForKey:@"error"];
                [hud hide:YES afterDelay:0.5f];
                [self.view endEditing:YES];
            }
            
        }];
    }
    if (type == 1) {
        [bUser signUpInBackground];
    }
    
    
    [bUser release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
