//
//  NetworkHelper.m
//  Calendar
//
//  Created by 钟文成(外包) on 2018/1/25.
//  Copyright © 2018年 钟文成(外包). All rights reserved.
//

#import "NetworkHelper.h"
#import "AFNetworking.h"
#import "ModelFactory.h"

@implementation NetworkHelper

// 初始化方法，默认连接类型为异步连接
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        _connectType = AsynConnect;
    }
    return self;
}




/**
 *    @brief    按照请求url，接口类型，请求方式，请求参数来进行连接
 *
 *    @param     url     请求地址
 *    @param     networkInterface     请求的接口类型，参考 ModeFactory
 *    @param     httpMethod     http请求方式
 *    @param     parameter     请求参数
 */
//- (void)connectUrl:(NSString *)url
//withNetworkInterface:(NetworkInterface)networkInterface
//        httpMethod:(NSString *)httpMethod
//         parameter:(NSString *)parameter
//{
//    //  NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
//    //  NSLog(@"%@", parameter);
//    //    NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
//    NetworkConnection *connection = [[NetworkConnection alloc] initWithUrl:url connectType:_connectType];
//    [connection setDelegate:self];
//    _networkInterface = networkInterface;
//    if (httpMethod == nil)
//        httpMethod = @"GET";
//    [connection setHTTPMethod:httpMethod];
//    if ([httpMethod isEqualToString:@"GET"])
//        [connection setGetParameter:parameter];
//    else if ([httpMethod isEqualToString:@"POST"])
//        [connection setPostParameter:parameter];
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//
//    //  根据连接类型选择如何启动连接，如果为异步连接，则判断是否是下载文件url或者是上传下载状态的请求，如果是，分别加入对应的请求队列（线程迟）中
//    if (AsynConnect == _connectType) {
//
//        if (NetworkInterfaceMaterialURL == _networkInterface)
//            [connection startupDownloadUrlAsynConnection];
//        else if (NetworkInterfaceUploadMaterialDownloadStatus == _networkInterface)
//            [connection startupUploadDownloadStatusAsynConnection];
//        else
//            [connection startupAsynConnection];
//    }
//    else {
//        [connection startupSynConnection];
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    }
//}


#pragma mark NetworkConnectionDelegate
/**
 *    @brief     NetworkConnection的代理方法，在请求失败之后执行
 *
 *    @param     networkConnection     发生错误的networkConnection对象
 *    @param     errorCode     错误代码
 */
//- (void)networkConnection:(NetworkConnection *)networkConnection didFailWithError:(NSInteger)errorCode {
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    if (_delegate && [self.delegate respondsToSelector:@selector(networkHelper:networkDidError:)]) {
//        [_delegate networkHelper:self networkDidError:errorCode];
//    }
//
//}



/**
 *    @brief    NetworkConnection的代理方法，在请求完成之后执行，请求完成之后，将返回的json字符串通过ModelFactory进行数据解析，将json数据重新封装成可以使用的对象，并通过代理方法返回给调用者
 *
 *    @param     networkConnection     完成请求的networkConnection对象
 *    @param     data     服务器响应的数据
 */
//- (void)networkConnection:(NetworkConnection *)networkConnection didFinishLoadingData:(NSData *)data {
//    NSArray *productsArray = nil;
//    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *dictionaryFromJsonString = [jsonString JSONValue];
//
//    //NSLog(@"jsonstr=%@",jsonString);
//    NSLog(@"dictionaryFromJsonString%@",dictionaryFromJsonString);  //下载地址
//
//
//
//    if ([dictionaryFromJsonString count] > 0 && !self.isCheckVersionUpdate)
//        productsArray = [ModelFactory productsOfNetworkInterface:_networkInterface withDataSource:dictionaryFromJsonString];
//    else
//        productsArray = (NSArray *)dictionaryFromJsonString;
//    NSLog(@"*******接口信息**********%u",_networkInterface);
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    if (_delegate && [_delegate respondsToSelector:@selector(networkHelper:didCompleteObjects:)]) {
//        [_delegate networkHelper:self didCompleteObjects:productsArray];
//    }
//
//}



//
-(void)requestWithURLStr:(NSString *)url andNetworkInterface:(NetworkInterface)networkInterface andHttpMethod:(NSString *)httpMethod andParameter:(NSDictionary *)parameter{
    
    if ([httpMethod isEqualToString:@"GET"]) {
        [self getRequestWithURL:url andParameter:parameter];
    }else{
        [self postRequestWithURL:url andParameter:parameter];
    }
}

-(void)getRequestWithURL:(NSString*)urlStr andParameter:(NSDictionary *)parameter{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    //
    [manager GET:urlStr parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        NSArray *productsArray = nil;
        NSLog(@"-----请求成功----:%@",responseObject);
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([dictionary count] > 0 && !self.isCheckVersionUpdate)
            productsArray = [ModelFactory productsOfNetworkInterface:_networkInterface withDataSource:dictionary];
        else
            productsArray = (NSArray *)dictionary;
        NSLog(@"*******接口信息**********%u",_networkInterface);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (_delegate && [_delegate respondsToSelector:@selector(networkHelper:didCompleteObjects:)]) {
            [_delegate networkHelper:self didCompleteObjects:productsArray];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        NSLog(@"请求失败---%@---%@",[error localizedFailureReason],error);
        
    }];
    
}

-(void)postRequestWithURL:(NSString*)urlStr andParameter:(NSDictionary *)parameter{
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    /***其实在manager方法里面已经设置了***/
    //申明返回的结果是json类型
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    //manager.requestSerializer=[AFJSONRequestSerializer serializer];
    
    
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    //发送请求
    [manager POST:urlStr parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        //进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        //
        NSArray *productsArray = nil;
        NSLog(@"-----请求成功----:%@",responseObject);
        
        NSDictionary *dictionary = (NSDictionary *)responseObject;
        
        NSLog(@"message:%@",dictionary[@"message"]);
        
        if ([dictionary count] > 0 && !self.isCheckVersionUpdate)
            productsArray = [ModelFactory productsOfNetworkInterface:_networkInterface withDataSource:dictionary];
        else
            productsArray = (NSArray *)dictionary;
        NSLog(@"*******接口信息**********%u",_networkInterface);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (_delegate && [_delegate respondsToSelector:@selector(networkHelper:didCompleteObjects:)]) {
            [_delegate networkHelper:self didCompleteObjects:productsArray];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败---%@---%@",[error localizedFailureReason],error);
        
    }];
    
}


@end
