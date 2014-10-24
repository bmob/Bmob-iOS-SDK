//
//  Bmob.h
//  BmobSDK
//
//  Created by Bmob on 13-7-31.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//包含头文件
#import "BmobObject.h"
#import "BmobFile.h"
#import "BmobGeoPoint.h"
#import "BmobQuery.h"
#import "BmobUser.h"
#import "BmobCloud.h"
#import "BmobConfig.h"
#import "BmobRelation.h"
#import "BmobObjectsBatch.h"
#import "BmobPush.h"
#import "BmobInstallation.h"
#import "BmobACL.h"
#import "BmobRole.h"
#import "BmobImage.h"
#import "BmobEvent.h"

@interface Bmob : NSObject


/**
 *	向Bmob注册应用
 *
 *	@param	appKey	在网站注册的appkey
 */
+(void)registerWithAppKey:(NSString*)appKey;


/**
 *  得到服务器时间戳
 *
 *  @return 时间戳字符串 (到秒)
 */
+(NSString*)getServerTimestamp;



@end
