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
@class BmobSliceResult;

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
typedef void (^BmobFileBatchProgressBlock)(int index ,float progress);;
typedef void (^BmobFileBatchResultBlock)(NSArray *array,BOOL isSuccessful ,NSError *error);

UIKIT_STATIC_INLINE NSString* Version()
{
	return @"1.5.4";
}


//pro

typedef void(^BmobFileResultBlock)(BOOL isSuccessful,NSError *error,NSString *filename,NSString *url);
typedef void(^BmobFileDownloadResultBlock)(BOOL isSuccessful,NSError *error,NSString *filepath);
typedef void(^BmobProgressBlock)(CGFloat progress);
typedef void(^BmobBatchProgressBlock)();

typedef void(^BmobBatchFileUploadResultBlock)(NSArray *filenameArray,NSArray *urlArray,NSError *error);
typedef void(^BmobIndexAndProgressBlock)(NSUInteger index,CGFloat progress);

typedef BmobFileDownloadResultBlock BmobLocalImageResultBlock;
typedef BmobBatchProgressBlock       BmobCompleteBlock ;

typedef void(^BmobSliceResultBlock)(BmobSliceResult *result);

typedef enum {
    ThumbnailImageScaleModeWidth    = 1,//指定宽，高自适应，等比例缩放;
    ThumbnailImageScaleModeHeight   = 2,//指定高， 宽自适应，等比例缩放
    ThumbnailImageScaleModeLongest  = 3,//指定最长边，短边自适应，等比例缩放;
    ThumbnailImageScaleModeShortest = 4,//指定最短边，长边自适应，等比例缩放;
    ThumbnailImageScaleModeMax      = 5,//指定最大宽高， 等比例缩放;
    ThumbnailImageScaleModeFixed    = 6 //固定宽高， 居中裁剪
}ThumbnailImageScaleMode;





#endif
