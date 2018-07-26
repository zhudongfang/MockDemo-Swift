//
//  RootViewController.swift
//  MockDemo-Swift
//
//  Created by 朱东方 on 2018/7/26.
//  Copyright © 2018年 LuckyPig. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.performSegue(withIdentifier: "OHHTTPStubs", sender: nil)
    }
}
