//
//  BmobPay.h
//  BmobSDK
//
//  Created by 陈超邦 on 2016/12/29.
//  Copyright © 2016年 Bmob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BmobConfig.h"

/*
 错误码含义
 
 |错误码 |含义        |
 |------|:---------:|
 | 4000 | 支付类型错误 |
 | 4001 | 返回可用数据为空 |
 | 4002 | 查询不到订单号 |
 | 4004 | 网络错误 |
 | 4005 | 应用未安装 |
 | 4006 | 取消付款 |
 | 4007 | 价格超出限额 |
 ----------------
 | 其他  | - 请查看返回信息 - |
 */

@interface BmobPay : NSObject

/**
 支付类型选择，暂时只支持支付宝付款
 
 - BmobAlipay: 支付宝付款
 */
typedef NS_ENUM(NSInteger, BmobPayType) {
    BmobAlipay = 3
};

//支付查询结果 Block
typedef void (^BmobPayResultBlock) (NSDictionary *resultDic, NSError *error);

/**
 调用支付接口
 
 @param payType 支付类型选择，暂时只支持支付宝付款，接口类型预留
 @param price 订单价格，限额 0-5000
 @param orderName 订单名称
 @param describe 订单描述
 @param result 支付回调
 */
+ (void)payWithPayType:(BmobPayType)payType
                 price:(NSNumber *)price
             orderName:(NSString *)orderName
              describe:(NSString *)describe
                result:(void(^)(BOOL isSuccessful, NSError *error))result;

/**
 支付结果自助查询
 */
+ (void)queryWithResult:(BmobPayResultBlock)result;

@end
