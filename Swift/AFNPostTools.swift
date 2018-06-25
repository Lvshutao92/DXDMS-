//
//  AFNPostTools.swift
//  DXDMS
//
//  Created by 吕书涛 on 2018/3/30.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

import UIKit

class AFNPostTools: AFHTTPSessionManager {
    static let shared = AFNPostTools()
    
    func postWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        let url = URL(string: path)
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(Manager.redingwenjianming("token.text"), forHTTPHeaderField: "token")
        request.setValue(Manager.redingwenjianming("companyID.text"), forHTTPHeaderField: "companyId")
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            if let data = data {
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    success(result)
                }
            }else {
                failure(error!)
            }
        }
        dataTask.resume()
    }
    func NSString(str:NSString) -> NSString {
        let string = "http://dms-image.dxracer.com.cn/" + (str as String)
        return string as NSString
    }
    func KURLNSString(str:NSString) -> NSString {
        let string = "http://10.0.0.24:8888/dxracer/app/" + (str as String)
        return string as NSString
    }
}
    





