//
//  main.m
//  BmobSDKTest
//
//  Created by Bmob on 13-12-31.
//  Copyright (c) 2013年 bmob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>
#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    //应用key是3124f50157a5df138aba77a85e1d8909。可更换为您的应用的key
    [Bmob registerWithAppKey:@"3124f50157a5df138aba77a85e1d8909"];
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
