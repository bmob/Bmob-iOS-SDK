//
//  BmobFile.h
//  NSStreamTest
//
//  Created by Bmob on 14-11-4.
//  Copyright (c) 2014年 bmob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobConfig.h"


/**
 *  提供文件相关功能接口,上传服务接口将在7月份停止，请及时更换成BmobFile上传下载
 */
@interface BmobProFile : NSObject


/**
 *  下载文件
 *
 *  @param filename      文件名
 *  @param block         下载的结果
 *  @param progressBlock 下载的进度
 */
+(void)downloadFileWithFilename:(NSString *)filename
                          block:(BmobFileDownloadResultBlock)block
                       progress:(BmobProgressBlock)progressBlock;

/**
 *  存放下载文件的图片的文件夹的大小
 *
 *  @return 文件夹的大小
 */
+(long long)cacheFizesSize;

/**
 *  清除下载的图片跟缩略图图片
 */
+(void)cleanCache;



/**
 *  本地缩略图处理
 *
 *  @param filepath 图片的路径
 *  @param m        图片处理的模式
 *  @param w        宽度
 *  @param h        高度
 *  @param block    处理的结果信息，包括是否成功，错误信息，文件的地址
 */
+(void)localThumbnailImageWithFilepath:(NSString *)filepath
                                  mode:(ThumbnailImageScaleMode )m
                                 width:(CGFloat)w
                                height:(CGFloat)h
                           resultBlock:(BmobLocalImageResultBlock)block;

/**
 *  开启安全验证后的url签名
 *
 *  @param filename  文件名
 *  @param urlString 文件的url地址
 *  @param validTime 有效时间 单位：秒
 *  @param a         accessKey
 *  @param s         secretKey
 *
 *  @return 签名后的url地址
 */
+(NSString *)signUrlWithFilename:(NSString *)filename
                             url:(NSString *)urlString
                       validTime:(int)validTime
                       accessKey:(NSString *)a
                       secretKey:(NSString *)s;

# pragma mark -  得到访问url及删除上传文件
/**
 *  得到直接访问文件的url
 *
 *  @param uuid  上传文件时得到的uuid
 *  @param block 返回的回调
 */
+(void) getFileAcessUrlWithFileName:(NSString*)fileName
                       callBack:(BmobGetAccessUrlBlock)block;

/**
 *  删除已上传文件
 *
 *  @param uuid  上传文件时得到的uuid
 *  @param block 返回的回调
 */
+(void) deleteFileWithFileName:(NSString*)fileName
                  callBack:(BmobBooleanResultBlock)block;

@end
