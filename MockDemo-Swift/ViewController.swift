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

    var testError = false
    var testParams = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMocks()
    }
    
    func addMocks() {
        let error = NSError(domain: "cmcm.com", code: -1, userInfo: nil);
        let params = "{\"name\"=\"ming\"}"
        let response = "{\"error\": 0, \"data\": {}}"
        
        if (!testError) {
            // Get
            mockRequest("GET", HttpGetUrl).andReturn(200)?.withBody(response)
            mockRequest("GET", HttpsGetUrl).andReturn(200)?.withBody("get.json")
            // Post
            mockRequest("POST", HttpPostUrl).andReturn(200)?.withBody("post.json")
            mockRequest("POST", HttpsPostUrl).withBody(params)?.andReturn(200)?.withBody("post.json")
        } else {
            // Get
            mockRequest("GET", HttpGetUrl).andFailWithError(error)
            mockRequest("GET", HttpsGetUrl).withBody(params)?.andFailWithError(error)
            // Post
            mockRequest("POST", HttpPostUrl).andFailWithError(error)
            mockRequest("POST", HttpsPostUrl).withBody(params)?.andFailWithError(error)
        }
        
        // Get 没有 withBody，只能匹配URL，可以修改库做到匹配queryItems
    }
    
    @IBAction func handleMockSwitchValueChange(_ sender: UISwitch) {
        if (sender.isOn) {
            addMocks()
            GYHttpMock.sharedInstance().start()
        } else {
            GYHttpMock.sharedInstance().stop()
        }
    }
    
    @IBAction func handleParamsSwitchValueChange(_ sender: UISwitch) {
        testParams = sender.isOn
    }
    
    @IBAction func handleErrorSwitchValueChange(_ sender: UISwitch) {
        testError = sender.isOn
        
        GYHttpMock.sharedInstance().stop();
        addMocks()
    }
    
    // Http
    
    @IBAction func testHttpGet(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpGet(["name": "ming"])
        } else {
            ApiClient.shared.testHttpGet(nil)
        }
    }
    
    @IBAction func testHttpPost(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpPost(["name": "ming"])
        } else {
            ApiClient.shared.testHttpPost(nil)
        }
    }

    // Https
    
    @IBAction func testHttpsGet(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpsGet(["name": "ming"])
        } else {
            ApiClient.shared.testHttpsGet(nil)
        }
    }
    
    @IBAction func testHttpsPost(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpsPost(["name": "ming"])
        } else {
            ApiClient.shared.testHttpsPost(nil)
        }
    }
}

