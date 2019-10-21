//
//  WebViewController.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/21/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webVew: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string:"https://www.youtube.com/watch?v=SUXWAEX2jlg")
        let myRequest = URLRequest(url: myURL!)
        webVew.loadRequest(myRequest)
    }

}
