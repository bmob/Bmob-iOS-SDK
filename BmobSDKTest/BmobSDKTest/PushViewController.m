//
//  PushViewController.m
//  BmobSDKTest
//
//  Created by Bmob on 14-4-30.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import "PushViewController.h"
#import <BmobSDK/Bmob.h>

@interface PushViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView     *_pushTableView;
}

@end

@implementation PushViewController

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
    self.view.backgroundColor             = [UIColor whiteColor];
    _pushTableView                        = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight-64)];
    _pushTableView.dataSource             = self;
    _pushTableView.delegate               = self;
    [self.view addSubview:_pushTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [_pushTableView setDataSource:nil];
    [_pushTableView setDelegate:nil];
    [_pushTableView release];
    _pushTableView = nil;
    [super dealloc];
}

#pragma mark - UITableView Datasource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"推送给所有人";
            break;
        case 1:
            cell.textLabel.text = @"推送给安卓用户";
            break;
        case 2:
            cell.textLabel.text = @"推送给苹果用户";
            break;
        case 3:
            cell.textLabel.text = @"推送给某个用户";
            break;
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self sendPushWithType:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)sendPushWithType:(NSInteger)type{
    
    BmobPush *push = [BmobPush push];
    BmobQuery *query = [BmobInstallation query];
    
    switch (type) {
        case 0:{
            [push setMessage:@"所有人的推送的消息"];
        }
            break;
        case 1:{
            [query whereKey:@"deviceType" equalTo:@"android"];
            [push setQuery:query];
            [push setMessage:@"推送给安卓用户的消息"];
        }
            break;
        case 2:{
            [query whereKey:@"deviceType" equalTo:@"ios"];
            [push setQuery:query];
            [push setMessage:@"推送给苹果用户的消息"];
        }
            break;
        case 3:{
            //特定的苹果用户为deviceToken，特定的安卓用户为installationId
            [query whereKey:@"deviceToken" equalTo:@"xxxxxxxxxxxxxxxx"];
            [push setQuery:query];
            [push setMessage:@"推送给某个苹果用户的消息"];
        }
            break;
        default:
            break;
    }
    
    [push sendPushInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        NSLog(@"error %@",[error description]);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
