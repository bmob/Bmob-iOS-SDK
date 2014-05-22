//
//  BmobFile.h
//  BmobSDK
//
//  Created by Bmob on 13-9-10.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobConfig.h"

@interface BmobFile : NSObject



/**
 *	文件名
 */
@property(nonatomic,retain)NSString  *name;

/**
 *	文件的地址
 */
@property(nonatomic,retain)NSString  *url;

/**
 *	文件的组名
 */
@property(nonatomic,retain)NSString  *group;



/**
 *	创建BmobFile对象
 *
 *	@param	className	关联的数据库表名
 *	@param	filePath	文件路径
 *
 *	@return	BmobFile对象实例
 */
-(id)initWithClassName:(NSString*)className withFilePath:(NSString*)filePath;

/**
 *  创建BmobFile对象
 *
 *  @param className 关联的数据库表名
 *  @param fileName  文件名称，请加上后缀
 *  @param data      二进制数据
 *
 *  @return BmobFile对象实例
 */
-(id)initWithClassName:(NSString *)className  withFileName:(NSString*)fileName  withFileData:(NSData*)data;

/**
 *	上传文件并保存,使用同步的方法保存，故
 *  请勿在GCD使用该方法
 */
-(BOOL)save;

/**
 *  异步上传文件并保存
 *
 *  @param block 返回保存结果与信息，如果保存成功，则无返回信息
 */
-(void)saveInBackground:(BmobBooleanResultBlock)block;

/**
 *  异步上传文件并保存
 *
 *  @param block         返回保存结果与信息，如果保存成功，则无返回信息
 *  @param progressBlock 上传进度
 */
-(void)saveInBackground:(BmobBooleanResultBlock)block withProgressBlock:(void(^)(float progress))progressBlock;



/**
 *  取消上传
 */
-(void)cancle;

@end
