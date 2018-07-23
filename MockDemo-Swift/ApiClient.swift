//
//  HttpClient.swift
//  MockDemo-Swift
//
//  Created by 朱东方 on 2018/7/23.
//  Copyright © 2018年 LuckyPig. All rights reserved.
//

import Foundation
import Alamofire

@objc class ApiClient : NSObject {
    
    //
    @objc static let shared: ApiClient = ApiClient()
    
    var url = "http://api.androidhive.info/volley/person_object.json"
    
    func getPerson() {
        Alamofire.request(url).responseJSON { response in
            print(response)
        }
    }
}