//
//  LoginViewController.m
//  BmobSDKTest
//
//  Created by Bmob on 13-8-8.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/BmobUser.h>//"BmobUser.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
#define kMBProgressHUD 9999

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
    
    self.title = @"登陆";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [navRightBtn setFrame:CGRectMake(0, 0, 50, 40)];
    [navRightBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [navRightBtn addTarget:self action:@selector(testLogin) forControlEvents:UIControlEventTouchUpInside];
    
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


-(void)testLogin{
    
    UITextField *userUTF = (UITextField*)[self.view viewWithTag:100];
    UITextField *passwordUTF = (UITextField*)[self.view viewWithTag:101];
    
    [BmobUser logInWithUsernameInBackground:userUTF.text password:passwordUTF.text block:^(BmobUser *user, NSError *error) {
        
        MBProgressHUD *hud = (MBProgressHUD*)[self.navigationController.view viewWithTag:kMBProgressHUD];
        hud.labelText = @"注册中";
        NSLog(@"error %@",[error description]);
        [self.view endEditing:YES];
        if (!error) {
            if (user) {
                NSLog(@"ok   username————————%@",[user objectForKey:@"username"]);
                [hud show:true];
                hud.labelText = @"登录成功！";
                [hud hide:YES afterDelay:0.5f];
            }
        }
        else{
            hud.labelText = [[error userInfo] objectForKey:@"error"];
            [hud show:YES];
            [hud hide:YES afterDelay:0.5f];
        }
    }];
//    [BmobUser logInWithUsernameInBackground:userUTF.text password:passwordUTF.text];
    
//    [self performSelector:@selector(updateUserInfo) withObject:nil afterDelay:0.7f];
    
}

-(void)updateUserInfo{
    BmobUser *user = [BmobUser getCurrentUser];
    [user setObject:@"1134@qq.com" forKey:@"email"];
    
    NSLog(@"objectid %@",user.objectId);
       
    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"error %@",[error description]);
    }];

}


-(void)vierifyEmail{
    BmobUser *user = [BmobUser getCurrentUser];
    if ([user objectForKey:@"emailVerified"]) {
        if (![[user objectForKey:@"emailVerified"] boolValue]) {
            [user verifyEmailInBackgroundWithEmailAddress:@"xxxxxxxxxx"];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
