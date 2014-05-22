//
//  QueryViewController.h
//  BmobSDKTest
//
//  Created by Bmob on 13-8-8.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{

    int             _seletedID;
    NSMutableArray  *_dataArray;
    
    UITableView     *_queryTableView;

}




@end
