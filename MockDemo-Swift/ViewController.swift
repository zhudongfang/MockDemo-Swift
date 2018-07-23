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
    
    let reqParams: [String : Any] = ["name": "ming"]
    let mockParams = "name=ming"

    // 参数大于1, 拼接顺序不一样导致匹配失败 mock fail
    // let reqParams: [String : Any] = ["name": "ming", "age": 27]
    // let mockParams = "name=ming&age=27"
    
    let mockError = NSError(domain: "cmcm.com", code: -1, userInfo: nil);
    let mockResponse = "{\"error\": 0, \"data\": {}}"

    // 改进：
    // GET  match fullurl， 可以改为 query item
    // POST params_count>1 时顺序出错导致匹配失败。name=ming&age=27 vs age=27&name=ming，同样会出现在其他方法中
    // json_file 默认取得失framework那个bundle的，我们一般放到main bundle中
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMocks()
    }
    
    func addMocks() {

        // 示例：
        // http/https
        // get/post
        // params？ multi params
        // jsonstring/jsonfile
        
        if (!testError) {
            // Http
            mockRequest("GET", HttpGetUrl).andReturn(200)?.withBody(mockResponse)
            mockRequest("POST", HttpPostUrl).withBody(mockParams)?.andReturn(200)?.withBody("post.json")
            // Https
            mockRequest("GET", HttpsGetUrl).andReturn(200)?.withBody("get.json")
            mockRequest("POST", HttpsPostUrl).withBody(mockParams)?.andReturn(200)?.withBody("post.json")
        } else {
            // Http
            mockRequest("GET", HttpGetUrl).andFailWithError(mockError)
            mockRequest("POST", HttpPostUrl).andFailWithError(mockError)
            // Https
            mockRequest("GET", HttpsGetUrl).withBody(mockParams)?.andFailWithError(mockError)
            mockRequest("POST", HttpsPostUrl).withBody(mockParams)?.andFailWithError(mockError)
        }
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
            ApiClient.shared.testHttpGet(reqParams)
        } else {
            ApiClient.shared.testHttpGet(nil)
        }
    }
    
    @IBAction func testHttpPost(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpPost(reqParams)
        } else {
            ApiClient.shared.testHttpPost(nil)
        }
    }

    // Https
    
    @IBAction func testHttpsGet(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpsGet(reqParams)
        } else {
            ApiClient.shared.testHttpsGet(nil)
        }
    }
    
    @IBAction func testHttpsPost(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpsPost(reqParams)
        } else {
            ApiClient.shared.testHttpsPost(nil)
        }
    }
}

