//
//  DeleteViewController.m
//  BmobSDKTest
//
//  Created by Bmob on 13-8-9.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import "DeleteViewController.h"
#import <BmobSDK/BmobQuery.h>//"BmobQuery.h"
#import <BmobSDK/BmobObject.h>//"BmobObject.h"
#import "MBProgressHUD.h"
#import "MyBtn.h"

@interface DeleteViewController ()

@end

@implementation DeleteViewController

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
    
    self.title = @"删除";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField  *tableNameUTF = [[UITextField alloc] initWithFrame:CGRectMake(20, 20+50, 200, 30)];
    tableNameUTF.backgroundColor = [UIColor whiteColor];
    tableNameUTF.placeholder = @"姓名";
    tableNameUTF.tag = 100;
    [self.view addSubview:tableNameUTF];
    [tableNameUTF release];
    
    
    
    
    _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    UIButton  *choseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [choseBtn setTitle:@"查找" forState:UIControlStateNormal];
    [choseBtn setFrame:CGRectMake(250, 10+50, 60, 40)];
    [choseBtn addTarget:self action:@selector(testUpdate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choseBtn];
    
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.tag = kMBProgressHUD;
    [self.navigationController.view addSubview:hud];
    
    [hud release];
    
    
    
    _queryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60+50, 320, screenHeight-64-50)];
    _queryTableView.dataSource = self;
    _queryTableView.delegate = self;
    
    [self.view addSubview:_queryTableView];
    [_queryTableView release];
    
    [self searchTheTable];
}


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
        [choseBtn setTitle:@"删除" forState:UIControlStateNormal];
        choseBtn.backgroundColor = [UIColor purpleColor];
        [choseBtn setFrame:CGRectMake(270, 0, 44, 44)];
        [choseBtn addTarget:self action:@selector(testDelete:) forControlEvents:UIControlEventTouchUpInside];
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


-(void)testUpdate{
    
    [self.view endEditing:YES];
    
    UITextField *tableClassUtf = (UITextField*)[self.view viewWithTag:100];
    
    if (!tableClassUtf.text) {
        return;
    }
    
    [_dataArray removeAllObjects];
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    [bquery orderByDescending:@"updatedAt"];
    MBProgressHUD *hud = (MBProgressHUD*)[self.navigationController.view viewWithTag:kMBProgressHUD];
    
    
    
    hud.labelText = @"查询中";
    
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

-(void)testDelete:(MyBtn*)sender{
    
    
    _seletedID = sender.selectNum;
    
    
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"GameScore"];
    [bquery orderByDescending:@"updatedAt"];
    MBProgressHUD *hud = (MBProgressHUD*)[self.navigationController.view viewWithTag:kMBProgressHUD];
    hud.labelText = @"删除中";
    
    [hud show:true];
    
    
    [hud hide:YES afterDelay:15.5f];
    
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (!error) {
            
            BmobObject  *bo = [array objectAtIndex:_seletedID];
            //无回调
//            [bo deleteInBackground];
            //有回调
            [bo deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                
                if (isSuccessful) {
                    
                    hud.labelText = @"删除成功！";
                    
                    [hud hide:YES afterDelay:0.5f];
                    
                    [self searchTheTable];
                }
                else{
                    hud.labelText = @"删除失败！";
                    [hud hide:YES afterDelay:0.5f];
                }
                
            }];
        }
        else{
            hud.labelText = @"删除失败！";
            [hud hide:YES afterDelay:0.5f];
        }
    }];
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
