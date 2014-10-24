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
@class BmobFile;

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


typedef enum {
    kBmobDirectionNorthWest = 0,    //水印图在原图的西北位置
    kBmobDirectionNorth,            //水印图在原图的正北位置
    kBmobDirectionNorthEast,        //水印图在原图的东北位置
    kBmobDirectionWest,             //水印图在原图的正西位置
    kBmobDirectionCenter,           //水印图在原图的中心位置
    kBmobDirectionEast,             //水印图在原图的正东位置
    kBmobDirectionSouthWest,        //水印图在原图的西南位置
    kBmobDirectionSouth,            //水印图在原图的正南位置
    kBmobDirectionSouthEast         //水印图在原图的东南位置
}BmobWatermarkDirection;

typedef enum {
    kBmobImageOutputBmobFile = 0,   //图片处理后返回BmobFile对象
    kBmobImageOutputStringStream    //图片处理后输出base64编码的字符串流
}BmobImageOutputType;

typedef enum {
    BmobActionTypeUpdateTable = 0,  //表更新
    BmobActionTypeUpdateRow,        //行更新
    BmobActionTypeDeleteTable,      //表删除
    BmobActionTypeDeleteRow         //行删除
}BmobActionType;

typedef enum {
    BmobSNSPlatformQQ = 0,          //qq平台
    BmobSNSPlatformSinaWeibo        //新浪微博
}BmobSNSPlatform;

typedef void (^BmobObjectResultBlock)(BmobObject *object, NSError *error);
typedef void (^BmobObjectArrayResultBlock)(NSArray *array, NSError *error);
typedef void (^BmobGeoPointBlock)(BmobGeoPoint *geoPoint, NSError *error);
typedef void (^BmobBooleanResultBlock) (BOOL isSuccessful, NSError *error);
typedef void (^BmobIntegerResultBlock)(int number, NSError *error) ;
typedef void (^BmobUserResultBlock)(BmobUser *user, NSError *error);
typedef void (^BmobIdResultBlock)(id object, NSError *error);
typedef void (^BmobFileBlock)(BmobFile *file,NSError *error);


UIKIT_STATIC_INLINE NSString* Version()
{
	return @"1.4.9";
}



#endif
