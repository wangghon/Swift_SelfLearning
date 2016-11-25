//
//  BaseNetworkRequest.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/24.
//  Copyright © 2016年 whb. All rights reserved.
//

import Foundation
import UIKit

let kStringAppName = "BaiduWalletApp"
let kStringOSPlatform = "IOS"
let kStringAppChannel = "walletapp"
let kStringAppVersion = "2.5.0"

class BaseNetworkRequest {
    
    var url: String {
        get {
            fatalError("subclass must define the URL")
        }
    }
    var params: [String:String] {
        get {
            var pms = [String: String]()
            pms["ua"] = userAgent
            
            return pms
        }
    }
    
    var userAgent: String {
        get {
            let appName = kStringAppName
            let appVersion = kStringAppVersion
            let osPlatform = kStringOSPlatform
            let appChannel = kStringAppChannel
            
            let mainScreen = UIScreen.main
            let szBounds = mainScreen.bounds.size
            let scale = mainScreen.scale
            
            let width = String(format:"%.0f", szBounds.width * scale)
            let height = String (format:"%.0f", szBounds.height * scale)
            let deviceInfo = UIDevice.current.model.replacingOccurrences(of: " ", with: "")
            
            let systemVersion = UIDevice.current.systemVersion
            
            let ua = String(format:"\(appName)-\(appVersion)-\(osPlatform)-\(appChannel)_\(width)_\(height)_\(deviceInfo)_\(systemVersion)_\(systemVersion)")
            return ua;
        }
    }
}
