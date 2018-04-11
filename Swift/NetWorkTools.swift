//
//  NetWorkTools.swift
//  DXDMS
//
//  Created by ilovedxracer on 2018/3/14.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

import UIKit
//枚举定义请求方式
enum HTTPRequestType {
    case GET
    case POST
}
class NetWorkTools: AFHTTPSessionManager {
    //单例
    static let shared = NetWorkTools()
    //   - 封装GET和POST 请求
    //   - Parameters:  参数
    //   - requestType: 请求方式
    //   - urlString:   urlString
    //   - parameters:  字典参数
    //   - completion:  回调
    func request(requestType: HTTPRequestType, urlString: String, parameters: [String: AnyObject]?, completion: @escaping (AnyObject?) -> ()) {
        
//        token = [Manager redingwenjianming:@"token.text"];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//
//        [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
//
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"image/jpeg",@"text/plain", nil];
        
        
        
        
        //成功回调
        let success = { (task: URLSessionDataTask, json: Any)->() in
            completion(json as AnyObject?)
        }
        //失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            print("网络请求错误 \(error)")
            completion(nil)
        }
        if requestType == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    func NSString(str:NSString) -> NSString {
        let string = "http://10.0.0.24:8888/dxracer/app/" + (str as String)
        return string as NSString
    }
    func KURLNSString(str:NSString) -> NSString {
        let string = "http://10.0.0.24:8888/dxracer/app/" + (str as String)
        return string as NSString
    }
}
