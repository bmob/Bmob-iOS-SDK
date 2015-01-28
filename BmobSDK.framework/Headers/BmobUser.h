//
//  BmobUser.h
//  BmobSDK
//
//  Created by Bmob on 13-8-6.
//  Copyright (c) 2013年 Bmob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobConfig.h"
#import "BmobObject.h"

@class BmobQuery;

@interface BmobUser : BmobObject



/**
 *  查询用户表
 *
 *  @return 创建用户表的查询
 */
+(BmobQuery *)query;

#pragma mark set
/**
 *	设置用户名
 *
 *	@param	username	提供的用户名
 */
-(void)setUserName:(NSString*)username;

/**
 *	设置密码
 *
 *	@param	password	提供的密码
 */
-(void)setPassword:(NSString*)password;

/**
 *	设置邮箱
 *
 *	@param	email	提供的邮箱
 */
-(void)setEmail:(NSString *)email;




/**
 *  用户登陆
 *
 *  @param username 用户名
 *  @param password 密码
 */
+(void)loginWithUsernameInBackground:(NSString*)username
                            password:(NSString*)password;


/**
 *  登陆后返回用户信息
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param block    是否成功登陆，若成功登陆返回用户信息
 */
+(void)loginWithUsernameInBackground:(NSString *)username
                             password:(NSString *)password
                                block:(BmobUserResultBlock)block;

/**
 *	注销登陆账号,删除本地账号
 */
+(void)logout;

/**
 *	后台注册
 */
-(void)signUpInBackground;


/**
 *	后台注册,返回注册结果
 *
 *	@param	block	返回成功还是失败
 */
-(void)signUpInBackgroundWithBlock:(BmobBooleanResultBlock)block;

/**
 *  邮件认证，在web端应用设置中又开启邮箱验证
 *
 *  @param email 邮箱地址
 */
-(void)verifyEmailInBackgroundWithEmailAddress:(NSString *)email;

/**
 *	通过邮件设置密码
 *
 *	@param	email	提供的邮件地址
 */
+(void)requestPasswordResetInBackgroundWithEmail:(NSString *)email;

/**
 *  得到邮箱验证的结果
 *
 *  @param block 邮箱验证的结果及其信息
 */
-(void)userEmailVerified:(BmobBooleanResultBlock)block;

/**
 *  第三方授权登录后，在Bmob生成一个bmob用户
 *
 *  @param infoDictionary  授权信息，格式为@{@"access_token":@"获取的token",@"uid":@"授权后获取的id",@"expirationDate":@"获取的过期时间（NSDate）"}
 *  @param platform        新浪微博，或者腾讯qq
 *  @param block           生成新的用户，跟结果信息
 */

+ (void)signUpInBackgroundWithAuthorDictionary:(NSDictionary *)infoDictionary
                                     platform:(BmobSNSPlatform)platform
                                        block:(BmobUserResultBlock)block;

/**
 *  第三方授权登录后，在Bmob生成一个bmob用户
 *
 *  @param infoDictionary  授权信息，格式为@{@"access_token":@"获取的token",@"uid":@"授权后获取的id",@"expirationDate":@"获取的过期时间（NSDate）"}
 *  @param platform        新浪微博，或者腾讯qq
 *  @param block           生成新的用户，跟结果信息
 */

+ (void)loginInBackgroundWithAuthorDictionary:(NSDictionary *)infoDictionary
                                      platform:(BmobSNSPlatform)platform
                                         block:(BmobUserResultBlock)block;
/**
 *  登录用户关联第三方账号
 *
 *  @param infoDictionary  授权信息，格式为@{@"access_token":@"获取的token",@"uid":@"授权后获取的id",@"expirationDate":@"获取的过期时间（NSDate）"}
 *  @param platform        新浪微博，或者腾讯qq
 *  @param block           关联结果跟信息
 */
-(void)linkedInBackgroundWithAuthorDictionary:(NSDictionary *)infoDictionary
                                     platform:(BmobSNSPlatform)platform
                                        block:(BmobBooleanResultBlock)block;


/**
 *  登录用户取消关联第三方账号
 *
 *  @param platform 新浪微博，或者腾讯qq
 *  @param block    取消关联结果跟信息
 */
-(void)cancelLinkedInBackgroundWithPlatform:(BmobSNSPlatform)platform
                                      block:(BmobBooleanResultBlock)block;



/**
 *	得到当前BmobUser
 *
 *	@return	返回BmobUser对象
 */
+(BmobUser*)getCurrentObject;

/**
 *	得到当前BmobUser
 *
 *	@return	返回BmobUser对象
 */
+(BmobUser*)getCurrentUser;



@end
