//
//  NetworkAgent.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/24.
//  Copyright © 2016年 whb. All rights reserved.
//

import Foundation
import Alamofire


class NetworkAgent {
    
    static let sharedInstance = NetworkAgent()
    
    func fetchNetworkData(_ request:BaseNetworkRequest, completion:((_ response:AnyObject?, _ error:NSError?)->Bool)?) {
        
        Alamofire.request(
            request.url,
            parameters: request.params)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching network data: \(response.result.error)")
                    completion?(nil, response.result.error as NSError?)
                    return
                }
                guard let value: AnyObject = response.result.value as AnyObject? else {
                        print("no value data received from network")
                    let error = NSError(domain: "com.baidu.walletapp", code: 90001, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Credit Data Not Available", comment: "")])
                        completion?(nil, error)
                    return
                }
                
                print("Response String: \(response.result.value)")
                completion?(value, nil)
            }
       }
}
