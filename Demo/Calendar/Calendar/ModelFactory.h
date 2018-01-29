//
//  ModelFactory.h
//  PACDMS_ipad
//
//  Created by yangfeiyue on 11-9-3.
//  Copyright 2011年 zbkc. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *	@brief	该枚举类型标示请求的接口
 */
typedef enum {
	NetworkInterfaceGetAESKey,                          /**< 请求AEK密钥接口 */
  NetworkInterfaceLogin,                                    /**< 登录请求接口 */
  NetworkInterfaceLogout,                                 /**< 注销接口 */
  NetworkInterfaceResetPassword,                     /**<  修改密码接口 */
  NetworkInterfaceConferences,                         /**< 获取会议接口 */
  NetworkInterfaceNotices,                                /**< 获取通知接口 */
  NetworkInterfaceNoticeAttachments,              /**< 获取通知附件列表接口 */
  NetworkInterfaceUpdateNoticeStatus,            /**< 上传通知状态接口 */
  NetworkInterfaceMaterials,                             /**< 获取文件列表接口 */
  NetworkInterfaceSecretaries,                          /**< 获取秘书列表接口 */
  NetworkInterfaceAgendasAndMaterials,            /**< 获取议程列表和其下文件接口 */
  NetworkInterfacePersonalDoc,                          /**< 获取个人文件接口 */
  NetworkInterfaceDailyDoc,                               /**< 获取日常文件接口 */
  NetworkInterfaceMaterialURL,                         /**< 获取文件地址接口 */
  NetworkInterfaceUploadMaterialDownloadStatus, /**< 上传文件下载状态接口 */
  NetworkInterfaceCouncils,                                /**< 获取历史文件分类接口 */
#pragma mark --20140325
////////////////////////////////////////////////////////////////////////////////
#pragma mark --- V2.0新增接口 
  NetworkInterfaceGroups,                                  /**< 获取组织机构列表接口 */
  NetworkInterfaceDeletedInfos,                        /**< 获取已删除文件信息列表接口 */
  
////////////////////////////////////////////////////////////////////////////////
#pragma mark --- V3.0新增接口 
  NetworkInterfaceVotingProposals,                     /**< 获取议案投票项列表接口 */
  NetworkInterfaceDirectories,                           /**< 获取目录列表接口 */
  NetworkInterfaceSchedule,                              /**< 获取会议排期表接口 */
////////////////////////////////////////////////////////////////////////////////
  
  NetworkInterfaceDefault                                 /**< 默认接口 */
}NetworkInterface;
         

/**
 *	@brief	模型工厂类，提供一个根据接口类型和数据源，生成接口对应的对象数组的接口
 */
@interface ModelFactory : NSObject {
}
/**
 *	@brief	模型加工厂的主要方法，每一个从网络响应的json对象都通过这个方法，进入到不同的生产流水线（不同的转换方法）转换为包含不同类型对象的对象数组
 *
 *	@param 	networkInterface 	表示响应数据为哪种类型的对象
 *	@param 	dataSource 	表示响应的json字典
 *
 *	@return	一个包含了productType描述的对象类型的对象数组，但是该数组的第0和1位置存放的是网络响应是否成功的标记，第2位置存放的是服务器返回对象的总数，从第3位置开始存放网络返回的对象
                 格式：     index --->    |        0        |          1          |          2          |          3         | ...
                                value --->    |     result    |    errorCode  |       total        |     object_1  | ...
 */
+ (NSArray *)productsOfNetworkInterface:(NetworkInterface)networkInterface withDataSource:(NSDictionary *)dataSource;
@end

