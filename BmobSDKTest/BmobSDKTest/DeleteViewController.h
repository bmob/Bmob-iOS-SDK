//
//  DeleteViewController.h
//  BmobSDKTest
//
//  Created by Bmob on 13-8-9.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeleteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray *        _dataArray;
    NSInteger               _seletedID;
    UITableView*            _queryTableView;

}

@end
