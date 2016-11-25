//
//  CreditNetworkRequest.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/25.
//  Copyright © 2016年 whb. All rights reserved.
//

import Foundation

let kStringCreditUrl = "https://www.baifubao.com/walletapp/umoney/queryumoneylist"

class CreditNetworkRequest: BaseNetworkRequest {
    
    override var url: String {
        get {
            return kStringCreditUrl
        }
    }
    
    override var params: [String: String] {
        get {
            var pms = super.params
            pms["cate[app_youqianhua]"] = ""
            
            return pms
        }
    }

}
