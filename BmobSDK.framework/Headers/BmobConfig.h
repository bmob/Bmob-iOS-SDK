//
//  BmobConfig.h
//  BmobSDK
//
//  Created by Bmob on 13-8-3.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BmobObject;
@class BmobGeoPoint;
@class BmobUser;

#ifndef BmobSDK_BmobConfig_h
#define BmobSDK_BmobConfig_h

typedef enum {
    kBmobCachePolicyIgnoreCache = 0,
    kBmobCachePolicyCacheOnly,
    kBmobCachePolicyNetworkOnly,
    kBmobCachePolicyCacheElseNetwork,
    kBmobCachePolicyNetworkElseCache,
    kBmobCachePolicyCacheThenNetwork
} BmobCachePolicy;

typedef void (^BmobObjectResultBlock)(BmobObject *object, NSError *error);
typedef void (^BmobObjectArrayResultBlock)(NSArray *array, NSError *error);
typedef void (^BmobGeoPointBlock)(BmobGeoPoint *geoPoint, NSError *error);
typedef void (^BmobBooleanResultBlock) (BOOL isSuccessful, NSError *error);
typedef void (^BmobIntegerResultBlock)(int number, NSError *error) ;
typedef void (^BmobUserResultBlock)(BmobUser *user, NSError *error);
typedef void (^BmobIdResultBlock)(id object, NSError *error);

UIKIT_STATIC_INLINE NSString* Version()
{
	return @"1.3.9";
}

#endif
