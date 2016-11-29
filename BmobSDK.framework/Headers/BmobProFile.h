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



@end
