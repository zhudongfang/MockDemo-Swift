//
//  ViewController.swift
//  MockDemo-Swift
//
//  Created by 朱东方 on 2018/7/23.
//  Copyright © 2018年 LuckyPig. All rights reserved.
//

import UIKit
import GYHttpMock

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // mockRequest("GET", "https://httpbin.org/get").andReturn(200)?.withBody("{\"name\": \"pgone\"}")
        mockRequest("GET", "https://httpbin.org/get").andFailWithError(NSError(domain: "", code: 1010, userInfo: nil))

        ApiClient.shared.getPerson()
    }
}

