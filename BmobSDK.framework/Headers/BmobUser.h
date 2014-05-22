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

@interface BmobUser : BmobObject



/**
 *	 BmobObject对象的id
 */
@property(nonatomic,retain)NSString *objectId;

/**
 *	 BmobObject对象的最后更新时间
 */
@property(nonatomic,retain)NSDate *updatedAt;

/**
 *	 BmobObject对象的生成时间
 */
@property(nonatomic,retain)NSDate *createdAt;

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
+(void)logInWithUsernameInBackground:(NSString*)username
                            password:(NSString*)password;


/**
 *  登陆后返回用户信息
 *
 *  @param username 用户名
 *  @param password 密码
 *  @param block    是否成功登陆，若成功登陆返回用户信息
 */
+ (void)logInWithUsernameInBackground:(NSString *)username
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
 *	@param	eamil	提供的邮件地址
 */
+(void)requestPasswordResetInBackgroundWithEmail:(NSString *)email;



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
