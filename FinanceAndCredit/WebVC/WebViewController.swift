//
//  WebViewController.swift
//  FinanceAndCredit
//
//  Created by HB on 16/9/13.
//  Copyright © 2016年 whb. All rights reserved.
//

import Foundation
import WebKit


class WebViewController: UIViewController {
    
    // MARK: Public Properties
    
    var allowsBackForwardNavigationGestures: Bool {
        get {
            return webView.allowsBackForwardNavigationGestures
        }
        set(value) {
            webView.allowsBackForwardNavigationGestures = value
        }
    }
    
    // MARK: Private properties
    lazy fileprivate var webView: WKWebView = {
        let web = WKWebView()
        
        //        web.navigationDelegate = self
        //        web.UIDelegate = self
        web.translatesAutoresizingMaskIntoConstraints = false
        
        return web
    }()
    
    // MARK: Public Methods
    
    class func createWebVCWithURL(_ URLString: String) -> WebViewController {
        
        let webVC = WebViewController()
        
        webVC.loadURLWithString(URLString)
        webVC.allowsBackForwardNavigationGestures = true;
        
        return webVC
    }
    
    func loadURLWithString(_ URLString: String) {
        if let URL = URL(string: URLString) {
            if (URL.scheme != "") && (URL.host != nil) {
                loadURL(URL)
            } else {
                loadURLWithString("http://\(URLString)")
            }
        }
    }
    
    
    func loadURL(_ URL: Foundation.URL, cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 0) {
        webView.load(URLRequest(url: URL, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval))
    }
    
    
    // MARK: Private Methods
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(webView)
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[webView]-0-|", options: [], metrics: nil, views: ["webView": webView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[webView]-0-|", options: [], metrics: nil, views: ["webView": webView]))
    }
    
    

}
