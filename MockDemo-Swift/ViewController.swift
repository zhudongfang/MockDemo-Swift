//
//  ViewController.swift
//  MockDemo-Swift
//
//  Created by 朱东方 on 2018/7/23.
//  Copyright © 2018年 LuckyPig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        ApiClient.shared.getPerson()
    }
}

