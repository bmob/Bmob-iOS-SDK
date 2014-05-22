//
//  QueryViewController.m
//  BmobSDKTest
//
//  Created by Bmob on 13-8-8.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import "QueryViewController.h"
#import <BmobSDK/BmobObject.h>//"BmobObject.h"
#import  <BmobSDK/BmobQuery.h>//"BmobQuery.h"
#import "MBProgressHUD.h"
#import  <BmobSDK/BmobUser.h>//"BmobUser.h"
#import <BmobSDK/BmobFile.h>//"BmobFile.h"
@interface QueryViewController ()

@end

@implementation QueryViewController


#define kMBProgressHUD   9900

-(id)init{
    
    
    self =[super init];
    if (self ) {
        
        
       // dataArray = [[NSMutableArray alloc] initWithObjects:@"升序", nil]
    }
    
    return self;
}


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
    
    
    
    self.title                             = @"查询";
    self.view.backgroundColor              = [UIColor whiteColor];

    _seletedID                             = 0;
    _dataArray                             = [[NSMutableArray alloc] initWithCapacity:0];
    MBProgressHUD *hud                     = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    hud.mode                               = MBProgressHUDModeCustomView;
    hud.tag                                = kMBProgressHUD;
    [self.navigationController.view addSubview:hud];
    [hud release];

    _queryTableView                        = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight-64-50)];
    _queryTableView.dataSource             = self;
    _queryTableView.delegate               = self;
    [self.view addSubview:_queryTableView];
    [self searchTheTable];
}


-(void)dealloc{
    _queryTableView.dataSource = nil;
    _queryTableView.delegate   = nil;
    [_queryTableView release];
    [_dataArray release];
    _dataArray                 = nil;

    [super dealloc];
}


-(void)hideKeyboard{
 [self.view endEditing:YES];
}



-(void)searchTheTable{
    
    
//    [self searchTableWithType:3];
    [self searchTableWhereKeyIsPointer];
}


-(void)searchTableWithType:(NSInteger)type{
    BmobQuery *bquery = [BmobQuery queryForUser];
    [bquery orderByDescending:@"updatedAt"];
    
    switch (type) {
        //
        case 0:
            break;
        case 1:
            [bquery selectKeys:@[@"userName"]];
            break;
        case 2:
            [bquery whereKeyExists:@"userName"];
            break;
        case 3:{
            BmobObject *obj = [BmobObject objectWithoutDatatWithClassName:@"Post" objectId:@"a1419df47a"];
            [bquery whereObjectKey:@"likes" relatedTo:obj];
        }
            break;
        case 4:{
        
        }
            break;
        default:
            break;
    }
    
    
    
    MBProgressHUD *hud = (MBProgressHUD*)[self.navigationController.view viewWithTag:kMBProgressHUD];
    hud.labelText = @"加载中";
    [hud show:true];
    [hud hide:YES afterDelay:15.5f];
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        for (BmobObject *obj in array) {
            NSLog(@"userName      %@ classname%@",obj.objectId,obj.className);
        }
        
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


-(void)searchTableWhereKeyIsPointer{
//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Comment"];
//    [bquery orderByDescending:@"updatedAt"];
//    [bquery whereKey:@"author" equalTo:[BmobUser objectWithoutDatatWithClassName:nil objectId:@"27bb999834"]];
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        for(BmobObject *obj in array){
//            NSLog(@"objectId==============>%@",obj.objectId);
//        }
//    }];
    
//    BmobQuery *inQuery = [BmobQuery queryWithClassName:@"Post"];
//    [inQuery whereKeyDoesNotExist:@"image"];
//    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Comment"];
//    [bquery whereKey:@"post" matchesQuery:inQuery];
//    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//        //do something
//    }];


    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Comment"];
    bquery.limit = 10;
    [bquery includeKey:@"post"];
    [bquery whereKeyExists:@"post"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        //do something
        for(BmobObject *obj in array){
            BmobObject *postObj = [obj objectForKey:@"post"];
            NSLog(@"postobj objectid %@",postObj.objectId);
        }
    }];

}


-(void)chose{
   
    
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
            
            hud.labelText = @"查询成功！";
            
            [hud hide:YES afterDelay:0.5f];
            
            [_dataArray setArray:array];
            
            [_queryTableView reloadData];
        }
        else{
            hud.labelText = @"查询失败！";
            [hud hide:YES afterDelay:0.5f];
        }
    }];
    
    
}

-(void)cancleChose{

    

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [_dataArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *myCell = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
        
    }

    if ([_dataArray count] != 0) {
        BmobObject *bo = (BmobObject*)[_dataArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [bo objectForKey:@"userName"];
    }

    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
