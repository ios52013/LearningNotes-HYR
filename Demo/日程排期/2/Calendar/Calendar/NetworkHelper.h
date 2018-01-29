//
//  NetworkHelper.h
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/25.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelFactory.h"

/**
 *    @brief    连接类型
 */
typedef enum {
    AsynConnect, /**< 异步连接 */
    SynConnect    /**< 同步连接 */
}ConnectType;



@protocol NetworkHelperDelegate;


@interface NetworkHelper : NSObject


/**
 *    @brief    NetworkHelperDelegate 代理
 */
@property (nonatomic, assign) id <NetworkHelperDelegate> delegate;

/**
 *    @brief    接口类型，标示所请求的网络数据接口，参考 ModelFactory类中的NetworkInterface定义
 */
@property (nonatomic, assign) NetworkInterface networkInterface;

/**
 *    @brief    操作对象，指定给每一个networkHelper对象作为附加参数
 */
@property (nonatomic, retain) id operatorObject;

/**
 *    @brief    连接类型，同步请求或者异步请求
 */
@property (nonatomic, assign) ConnectType connectType;

/**
 *    @brief    请求对象的标记
 */
@property (nonatomic, assign) int tag;
/**
 *  是否检查更新
 */
@property (nonatomic ,assign) BOOL isCheckVersionUpdate;

/**
 *    @brief    按照请求url，接口类型，请求方式，请求参数来进行连接
 *
 *    @param     url     请求地址
 *    @param     networkInterface     请求的接口类型，参考 ModeFactory
 *    @param     httpMethod     http请求方式
 *    @param     parameter     请求参数
 */
- (void)connectUrl:(NSString *)url
withNetworkInterface:(NetworkInterface)networkInterface
        httpMethod:(NSString *)httpMethod
         parameter:(NSString *)parameter;

-(void)requestWithURLStr:(NSString *)url andNetworkInterface:(NetworkInterface)networkInterface andHttpMethod:(NSString *)httpMethod andParameter:(NSDictionary *)parameter;

@end


@protocol NetworkHelperDelegate <NSObject>
@optional
/**
 *    @brief    代理方法，捕获连接错误时执行
 *
 *    @param     networkHelpler     发生错误的网络请求工具对象
 *    @param     errorCode     错误代码
 */
- (void)networkHelper:(NetworkHelper *)networkHelpler networkDidError:(NSInteger)errorCode;


/**
 *    @brief    代理方法，完成数据解析后执行
 *
 *    @param     networkHelpler     完成数据解析的网络请求工具对象
 *    @param     objectsArray     经过解析的服务器返回的数据对象数组
 */
- (void)networkHelper:(NetworkHelper *)networkHelpler didCompleteObjects:(NSArray *)objectsArray;

@end
