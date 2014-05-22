//
//  UpdateViewController.m
//  BmobSDKTest
//
//  Created by Bmob on 13-8-13.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import "UpdateViewController.h"
#import <BmobSDK/BmobObject.h>//"BmobObject.h"
#import <BmobSDK/BmobQuery.h>//"BmobQuery.h"
#import <BmobSDK/BmobFile.h>//"BmobFile.h"
#import "MBProgressHUD.h"
#import "MyBtn.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController


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
    
    self.title                 = @"更新";
    self.view.backgroundColor  = [UIColor whiteColor];

    _dataArray                 = [[NSMutableArray alloc] initWithCapacity:0];
    MBProgressHUD *hud         = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    hud.mode                   = MBProgressHUDModeCustomView;
    hud.tag                    = kMBProgressHUD;
    [self.navigationController.view addSubview:hud];
    [hud release];


    

    _queryTableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight-64-50)];
    _queryTableView.dataSource = self;
    _queryTableView.delegate   = self;
    [self.view addSubview:_queryTableView];


    [self searchTheTable];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    _queryTableView.dataSource = nil;
    _queryTableView.delegate   = nil;
    [_queryTableView release];
    [_dataArray release];
    [super dealloc];
}

//
-(void)searchTheTable{
    
    
    
    [_dataArray removeAllObjects];
    
    
   BmobQuery *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    [bquery orderByDescending:@"updatedAt"];
    MBProgressHUD *hud = (MBProgressHUD*)[self.navigationController.view viewWithTag:kMBProgressHUD];
    hud.labelText = @"加载中";
    
    [hud show:true];
    [hud hide:YES afterDelay:15.5f];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error) {
            
            hud.labelText = @"加载成功！";
            
            [hud hide:YES afterDelay:0.5f];
            
            [_dataArray setArray:array];
            
            [_queryTableView reloadData];
            
            
        }
        else{
            hud.labelText = @"加载失败！";
            [hud hide:YES afterDelay:0.5f];
        }
    }];
    
    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
        
        MyBtn  *choseBtn = [[MyBtn alloc] init];
        [choseBtn setTitle:@"更新" forState:UIControlStateNormal];
        choseBtn.backgroundColor = [UIColor purpleColor];
        [choseBtn setFrame:CGRectMake(270, 0, 44, 44)];
        [choseBtn addTarget:self action:@selector(updateData:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:choseBtn];
        choseBtn.tag = 100;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 44)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont boldSystemFontOfSize:20];
        nameLabel.tag = 101;
        [cell.contentView addSubview:nameLabel];
        [nameLabel release];
        
    }
    
    UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:101];
    if ([_dataArray count] != 0) {
        BmobObject *bo = (BmobObject*)[_dataArray objectAtIndex:indexPath.row];
        nameLabel.text = [bo objectForKey:@"playerName"];
    }
    
    MyBtn *choseBtn = (MyBtn*)[cell.contentView viewWithTag:100];
    choseBtn.selectNum = indexPath.row;
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


-(void)updateData:(MyBtn*)sender{

    _seletedID = sender.selectNum;
    UIAlertView  *alertView = [[UIAlertView alloc] initWithTitle:@"更新"
                                                         message:nil
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField  *tmpTextField = [alertView textFieldAtIndex:0];
    tmpTextField.placeholder = @"更新playerName";
    
    [alertView show];
    [alertView release];
    

}



-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    if (buttonIndex == [alertView cancelButtonIndex]) {
        return;
    }
    if (buttonIndex == 1) {
        UITextField  *tmpTextField = [alertView textFieldAtIndex:0];
        
        if (!tmpTextField.text) {
            return;
        }
        
        
        
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"GameScore"];
        
        [bquery orderByDescending:@"updatedAt"];
        
        
        
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {

            BmobObject  *bo = [array objectAtIndex:_seletedID];
            
            
            
            [bo setObject:tmpTextField.text forKey:@"playerName"];

            MBProgressHUD *hud = (MBProgressHUD*)[self.navigationController.view viewWithTag:kMBProgressHUD];
            hud.labelText = @"更新中";
            
            [hud show:true];
            
            
            [hud hide:YES afterDelay:15.5f];
            
            //无回调
//            [bo updateInBackground];
            //有回调
            [bo updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
                NSLog(@"error %@",[error description]);
                
                if (isSuccessful) {
                    
                    hud.labelText = @"更新成功！";
                    [hud hide:YES afterDelay:0.5f];
                    [_queryTableView reloadData];
                    
                    NSLog(@"1234%@",bo.updatedAt);
                    
                }
                else{
                    hud.labelText = @"更新失败！";
                    [hud hide:YES afterDelay:0.5f];
                }
                
            }];
            
        }];
    }
}



@end
