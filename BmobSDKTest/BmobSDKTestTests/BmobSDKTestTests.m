//
//  BmobSDKTestTests.m
//  BmobSDKTestTests
//
//  Created by Bmob on 13-12-31.
//  Copyright (c) 2013年 bmob. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <BmobSDK/Bmob.h>

@interface BmobSDKTestTests : XCTestCase

@end

@implementation BmobSDKTestTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    
    [Bmob registerWithAppKey:@"3124f50157a5df138aba77a85e1d8909"];
    NSLog(@"time stamp %@",[Bmob getServerTimestamp]);
    
}



@end
