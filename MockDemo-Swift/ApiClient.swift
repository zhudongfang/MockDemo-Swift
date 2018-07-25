//
//  HttpClient.swift
//  MockDemo-Swift
//
//  Created by 朱东方 on 2018/7/23.
//  Copyright © 2018年 LuckyPig. All rights reserved.
//

import Foundation
import Alamofire

public let HttpGetUrl   = "http://httpbin.org/get"
public let HttpPostUrl  = "http://httpbin.org/post"
public let HttpsGetUrl  = "https://httpbin.org/get"
public let HttpsPostUrl = "https://httpbin.org/post"

@objc class ApiClient : NSObject {
    
    @objc static let shared: ApiClient = ApiClient()
    
    @objc var testError: Bool = false
    
    func testHttpGet(_ params: Parameters?) {
        Alamofire.request(HttpGetUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil) .responseJSON { (response) in
            print("http get: \(response)")
        }
    }
    
    func testHttpsGet(_ params: Parameters?) {
        Alamofire.request(HttpsGetUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil) .responseJSON { (response) in
            print("https get: \(response)")
        }
        
    }
    
    func testHttpPost(_ params: Parameters?) {
        Alamofire.request(HttpPostUrl, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("http post: \(response)")
        }
    }
    
    func testHttpsPost(_ params: Parameters?) {
        Alamofire.request(HttpsPostUrl, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            print("https post: \(response)")
        }
    }
}
