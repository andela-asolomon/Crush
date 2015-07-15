//
//  WebViewController.swift
//  DemoInsta
//
//  Created by Ayoola Solomon on 7/7/15.
//  Copyright (c) 2015 Ayoola Solomon. All rights reserved.
//

import UIKit
import OAuthSwift

class WebViewController: OAuthWebViewController, UIWebViewDelegate {
    
    var targetURL : NSURL = NSURL()
    let webView : UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.frame = UIScreen.mainScreen().applicationFrame
        self.webView.scalesPageToFit = true
        self.webView.delegate = self
        self.view.addSubview(self.webView)
        loadAddressURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func handle(url: NSURL) {
        targetURL = url
        super.handle(url)
    }
    
    func loadAddressURL() {
        let req = NSURLRequest(URL: targetURL)
        self.webView.loadRequest(req)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.URL where (url.scheme == "oauth-swift"){
            self.dismissWebViewController()
        }
        
        return true
    }
    
}