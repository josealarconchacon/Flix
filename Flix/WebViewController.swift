//
//  WebViewController.swift
//  Flix
//
//  Created by Jose Alarcon Chacon on 10/21/19.
//  Copyright © 2019 Jose Alarcon Chacon. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, UIWebViewDelegate {
    
    @IBOutlet weak var webVew: UIWebView!
    

    var playMovieTrailer: [String: Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webVew.delegate = self
        let myURL = URL(string:"https://www.youtube.com/watch?v=SUXWAEX2jlg")
        let myRequest = URLRequest(url: myURL!)
        webVew.loadRequest(myRequest)
        
    }
}
