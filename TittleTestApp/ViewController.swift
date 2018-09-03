//
//  ViewController.swift
//  TittleTestApp
//
//  Created by Jackie on 30/8/2018.
//  Copyright © 2018 clarityhk.com. All rights reserved.
//

import UIKit
import TittleFramework
// TittleFramework is using CocoaAsyncSocket for socket connections.
// So your controller needs to implement GCDAsyncSocketDelegate

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let logger = HelloLogger()
        logger.hello(withText: "world")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

