//
//  OHTestViewController.swift
//  MockDemo-Swift
//
//  Created by 朱东方 on 2018/7/26.
//  Copyright © 2018年 LuckyPig. All rights reserved.
//

import UIKit
import OHHTTPStubs

class OHTestViewController: UIViewController {
    
    var testError = false
    var testParams = false
    
    let mockParams: [String : Any] = ["name": "ming"]
    var mockResponse: OHHTTPStubsResponse {
        get {
            return OHHTTPStubsResponse(jsonObject: ["data": "123"] , statusCode: 200, headers: nil)
        }
    }
    var mockError: OHHTTPStubsResponse {
        get {
            return OHHTTPStubsResponse(error: NSError(domain: "cmcm.com", code: -1, userInfo: nil))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "OHHTTPStubs Test"
        
        installMocks()
    }
    
    func installMocks() {
        
        // 示例：
        // http/https
        // get/post
        // params？ multi params
        // jsonstring/jsonfile
        
//        let s = "name=ming"
//        let paires = s.split(separator: "&")
//        var httpBody = Dictionary()
//        for kv in paires {
//            let parts = kv.split(separator: "=")
//            if parts.count != 2 {
//                continue
//            }
//            
//            httpBody[parts[0]] = parts[1]
//        }
        

        if (!testError) {
            // Http
            stub(condition: { (req) -> Bool in
                return isMethodGET()(req) && isAbsoluteURLString(HttpGetUrl)(req)
            }) { (req) -> OHHTTPStubsResponse in
                return self.mockResponse
            }
            stub(condition: { (req) -> Bool in
                return isMethodPOST()(req) && isAbsoluteURLString(HttpPostUrl)(req) && hasJsonBody(self.mockParams)(req)
            }) { (req) -> OHHTTPStubsResponse in
                return OHHTTPStubsResponse(jsonObject: ["data": "123"] , statusCode: 200, headers: nil)
            }
            
            // Https
            stub(condition: { (req) -> Bool in
                return isMethodGET()(req) && isScheme("https")(req) && isAbsoluteURLString(HttpsGetUrl)(req)
            }) { (req) -> OHHTTPStubsResponse in
                return self.mockResponse
            }
            stub(condition: { (req) -> Bool in
                return isMethodPOST()(req) && isScheme("https")(req) && isAbsoluteURLString(HttpsPostUrl)(req) && hasJsonBody(self.mockParams)(req)
            }) { (req) -> OHHTTPStubsResponse in
                return self.mockResponse
            }
        }
        else {
            // Http
            stub(condition: { (req) -> Bool in
                return isMethodGET()(req) && isAbsoluteURLString(HttpGetUrl)(req)
            }) { (req) -> OHHTTPStubsResponse in
                return self.mockError
            }
            stub(condition: { (req) -> Bool in
                return isMethodPOST()(req) && isAbsoluteURLString(HttpPostUrl)(req) && hasJsonBody(self.mockParams)(req)
            }) { (req) -> OHHTTPStubsResponse in
                return self.mockError
            }
            
            // Https
            stub(condition: { (req) -> Bool in
                return isMethodGET()(req) && isScheme("https")(req) && isAbsoluteURLString(HttpsGetUrl)(req)
            }) { (req) -> OHHTTPStubsResponse in
                return self.mockError
            }
            stub(condition: { (req) -> Bool in
                return isMethodPOST()(req) && isScheme("https")(req) && isAbsoluteURLString(HttpsPostUrl)(req) && hasJsonBody(self.mockParams)(req)
            }) { (req) -> OHHTTPStubsResponse in
                return self.mockError
            }
        }
        
        OHHTTPStubs.setEnabled(true)
    }
    
    func uninstallMocks() {
        OHHTTPStubs.removeAllStubs()
        OHHTTPStubs.setEnabled(false)
    }
    
    @IBAction func handleMockSwitchValueChange(_ sender: UISwitch) {
        if (sender.isOn) {
            installMocks()
        } else {
            uninstallMocks()
        }
    }
    
    @IBAction func handleParamsSwitchValueChange(_ sender: UISwitch) {
        testParams = sender.isOn
    }
    
    @IBAction func handleErrorSwitchValueChange(_ sender: UISwitch) {
        testError = sender.isOn
        
        uninstallMocks()
        installMocks()
    }
    
    // Http
    
    @IBAction func testHttpGet(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpGet(mockParams)
        } else {
            ApiClient.shared.testHttpGet(nil)
        }
    }
    
    @IBAction func testHttpPost(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpPost(mockParams)
        } else {
            ApiClient.shared.testHttpPost(nil)
        }
    }
    
    // Https
    
    @IBAction func testHttpsGet(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpsGet(mockParams)
        } else {
            ApiClient.shared.testHttpsGet(nil)
        }
    }
    
    @IBAction func testHttpsPost(_ sender: Any) {
        if (testParams) {
            ApiClient.shared.testHttpsPost(mockParams)
        } else {
            ApiClient.shared.testHttpsPost(nil)
        }
    }
}

