//
//  MainViewController.m
//  BmobSDKDemo
//
//  Created by Bmob on 13-11-28.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import "MainViewController.h"
#import "CreateTableViewController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobObject.h>
#import <BmobSDK/BmobUser.h>
#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "UpdateViewController.h"
#import "DeleteViewController.h"
#import "QueryViewController.h"
#import <BmobSDK/Bmob.h>
#import "JSONKit.h"
#import <CommonCrypto/CommonDigest.h>
#import <BmobSDK/BmobFile.h>
#import <BmobSDK/BmobCloud.h>
#import "MBProgressHUD.h"
#import <BmobSDK/BmobObjectsBatch.h>
#import "PushViewController.h"

@interface MainViewController (){
    int  _times;
}

@end

@implementation MainViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"测试SDK";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _times = 1;
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"初始化接口",@"添加数据",@"查询接口",@"更新接口",
                 @"删除接口",
                 @"用户注册接口",
                 @"登陆接口",
                 @"上传文件",
                 @"云端代码",
                 @"添加关联关系",
                 @"移除关联关系",
                 @"批量处理数据",
                 @"推送",
                 nil];
    
    
    CGSize size         = [UIScreen mainScreen].bounds.size;
    float height = 0.0f;
    if (IS_iOS7) {
        height= size.height;
    }else{
        height = size.height - 64;
    }
    UITableView *tmpUTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, height) style:UITableViewStylePlain];
    tmpUTV.delegate     = self;
    tmpUTV.dataSource   = self;

    [self.view addSubview:tmpUTV];
    [tmpUTV release];

    MBProgressHUD *hud  = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    hud.mode            = MBProgressHUDModeIndeterminate;
    hud.tag             = kMBProgressHUD;
    [self.navigationController.view addSubview:hud];
    [hud release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)testInit{
    BmobQuery *query = [BmobInstallation query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobInstallation *obj in array) {
            NSLog(@"objectId %@",obj.objectId);
        }
    }];
}



-(void)testPush{
    PushViewController *pvc = [[[PushViewController alloc] init] autorelease];
    [self.navigationController pushViewController:pvc animated:YES];
}

-(void)testCloudCode{

    NSDictionary  *dic = [NSDictionary  dictionaryWithObject:@"GameScore" forKey:@"table"];
    [BmobCloud callFunctionInBackground:@"sayhello" withParameters:dic block:^(id object, NSError *error) {
        
        if (error) {
            NSLog(@"error %@",[error description]);
        }
        NSLog(@"object      %@",object);
        
    }] ;

}


-(void)testCreateTable{
    CreateTableViewController *ctbv = [[[CreateTableViewController alloc] init] autorelease];
    [self.navigationController pushViewController:ctbv animated:YES];
}

-(void)testQuery{
    QueryViewController *ctbv = [[[QueryViewController alloc] init] autorelease];
    [self.navigationController pushViewController:ctbv animated:YES];
}

-(void)testUpdate{
    
    UpdateViewController *ctbv = [[[UpdateViewController alloc] init] autorelease];
    [self.navigationController pushViewController:ctbv animated:YES];
    
}

-(void)testDelete{
    
    DeleteViewController *ctbv = [[[DeleteViewController alloc] init] autorelease];
    [self.navigationController pushViewController:ctbv animated:YES];
}

-(void)testUser{
    SignUpViewController *ctbv = [[[SignUpViewController alloc] init] autorelease];
    [self.navigationController pushViewController:ctbv animated:YES];
}

-(void)testLogin{
    LoginViewController *ctbv = [[[LoginViewController alloc] init] autorelease];
    [self.navigationController pushViewController:ctbv animated:YES];
}


-(void)testGeoPoint{
    
}


- (void)addRelation{
    
    BmobObject *obj = [BmobObject objectWithoutDatatWithClassName:@"Post" objectId:@"a1419df47a"];
    BmobRelation *relation = [[[BmobRelation alloc] init] autorelease];
    [relation addObject:[BmobUser objectWithoutDatatWithClassName:nil objectId:@"27bb999834"]];
    [relation addObject:[BmobUser objectWithoutDatatWithClassName:nil objectId:@"25fb9b4a61"]];
    [obj addRelation:relation forKey:@"likes"];
    [obj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"error %@",[error description]);
    }];
    
    
    
}

-(void)removeRelation{
    BmobObject *obj = [BmobObject objectWithoutDatatWithClassName:@"Post" objectId:@"a1419df47a"];
    BmobRelation *relation = [[[BmobRelation alloc] init] autorelease];
    [relation removeObject:[BmobUser objectWithoutDatatWithClassName:nil objectId:@"27bb999834"]];
    [obj addRelation:relation forKey:@"likes"];
    [obj updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"error %@",[error description]);
    }];
}

-(void)testBathOperation{
    
    BmobObjectsBatch    *batch = [[[BmobObjectsBatch alloc] init] autorelease];
    [batch saveBmobObjectWithClassName:@"GameScore" parameters:@{@"aveScore": @{@"数学":@90},@"score":@78}];
    [batch updateBmobObjectWithClassName:@"GameScore" objectId:@"27eabbcfec" parameters:@{@"score": @85}];
    [batch deleteBmobObjectWithClassName:@"GameScore" objectId:@"30752bb92f"];
    [batch batchObjectsInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"batch error %@",[error description]);
    }];
    
}


-(void)uploadFile{
    NSBundle    *bundle = [NSBundle mainBundle];
    NSString *fileString = [NSString stringWithFormat:@"%@/cs.txt" ,[bundle bundlePath] ];
    BmobObject *obj = [[BmobObject alloc] initWithClassName:@"gameScoreFile"];
    BmobFile *file1 = [[BmobFile alloc] initWithClassName:@"Asc" withFilePath:fileString];
    [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [obj setObject:file1  forKey:@"userFile"];
            [obj saveInBackground];
            NSLog(@"file1 url %@",file1.url);
        }
    }];
}

-(void)dealloc{
    [dataArray release];
     [super dealloc];
}

#pragma mark tableview datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [dataArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString *myCell = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCell];
        cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] description];
    }
    
    return cell;
}


#pragma mark tableview delegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.row) {
        case 0:
            [self testInit];
            break;
        case 1:
            [self testCreateTable];
            break;
        case 2:
            [self testQuery];
            break;
        case 3:
            [self testUpdate];
            break;
        case 4:
            [self testDelete];
            break;
        case 5:
            [self testUser];
            break;
        case 6:
            [self testLogin];
            break;
        case 7:{
            [self uploadFile];
        }
            break;
        case 8:
            [self testCloudCode];
            break;
        case 9:
            [self addRelation];
            break;
        case 10:
            [self removeRelation];
            break;
        case 11:
            [self testBathOperation];
            break;
        case 12:
            [self testPush];
            break;
        default:
            break;
    }
}





@end
