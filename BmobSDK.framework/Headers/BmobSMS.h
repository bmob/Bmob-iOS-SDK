//
//  BmobSMS.h
//  BmobSDK
//
//  Created by limao on 15/6/15.
//  Copyright (c) 2015年 donson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobConfig.h"

/**
 *  短信验证码相关接口
 */
@interface BmobSMS : NSObject
/**
 *  请求验证码
 *
 *  @param number      手机号
 *  @param templateStr 模板名
 *  @param block       请求回调
 */
+ (void)requestSMSCodeInBackgroundWithPhoneNumber:(NSString*)number
                                      andTemplate:(NSString*)templateStr
                                      resultBlock:(BmobIntegerResultBlock)block;

/**
 *  验证验证码
 *
 *  @param number 手机号
 *  @param code   验证码
 *  @param block  回调
 */
+ (void)verifySMSCodeInBackgroundWithPhoneNumber:(NSString*)number andSMSCode:(NSString*)code resultBlock:(BmobBooleanResultBlock)block;

/**
 *  查询短信状态
 *
 *  @param smsId 验证码
 *  @param block 回调
 */
+ (void)querySMSCodeStateInBackgroundWithSMSId:(unsigned)smsId resultBlock:(BmobQuerySMSCodeStateResultBlock)block;

@end
