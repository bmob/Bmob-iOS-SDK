//
//  UpdateViewController.h
//  BmobSDKTest
//
//  Created by Bmob on 13-8-13.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{

    NSMutableArray*           _dataArray;
    NSInteger                 _seletedID;
    UITableView*              _queryTableView;
}

@end
