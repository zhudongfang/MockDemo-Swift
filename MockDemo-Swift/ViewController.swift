//
//  ViewController.swift
//  MockDemo-Swift
//
//  Created by 朱东方 on 2018/7/23.
//  Copyright © 2018年 LuckyPig. All rights reserved.
//

import UIKit
import OHHTTPStubs


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stub(condition: { (req) -> Bool in
            return isAbsoluteURLString("https://httpbin.org/get")(req)
        }) { (req) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(error: NSError(domain: "xx", code: 1001, userInfo: nil))
        }
        
        ApiClient.shared.getPerson()
    }
}

