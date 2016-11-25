//
//  CreditManager.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/16.
//  Copyright © 2016年 whb. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol CreditDataProtocol {
    
    var creditModel : CreditModel? { get }
    weak var delegate : CreditDataHandlingDelegate? {get set}
    
    func updateRemoteData()  -> Bool
    func updateLocalData()  -> Bool
}

protocol CreditDataHandlingDelegate : class {
    func didParseData(_ dataManager:CreditDataProtocol, dataModel:CreditModel, error: NSError?)
}

open class CreditManager : CreditDataProtocol {
    
    static let sharedInstance = CreditManager()
    var creditModel : CreditModel?
    var delegate : CreditDataHandlingDelegate?
    
    fileprivate init() {}

    func updateLocalData() -> Bool {
        
        let fileName = NSHomeDirectory() + "/Documents/creditdata.bin"
        let response = try? String(contentsOfFile: fileName, encoding: String.Encoding.utf8)
        let jsonData : Data
        
        if (response == nil) {
            let path : String = Bundle.main.path(forResource: "creditjsonfile", ofType: "json") as String!
            jsonData = (try? Data(contentsOf: URL(fileURLWithPath: path))) as Data!
        } else {
            jsonData = response?.data(using: String.Encoding.utf8) as Data!
        }
        
        let readableJSON = JSON(data: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers , error: nil)
        
        let creditModel : CreditModel? = CreditModel(json: readableJSON)
        
        if let data = creditModel {
            delegate?.didParseData(self, dataModel: data, error: nil)
            return true
        } else {
            return false
        }
    }
    
    func updateRemoteData()  -> Bool {
        
        let request = CreditNetworkRequest()
        
        NetworkAgent.sharedInstance.fetchNetworkData(request) { response, error in
            
            guard response != nil else {
                return false
            }
            
            if (error != nil) {
                return false
            }
            
            let readableJSON = JSON(response!)
            
            let creditModel: CreditModel? = CreditModel(json: readableJSON)
            
            if let data = creditModel {
                
                
                self.delegate?.didParseData(self, dataModel: data, error: nil)
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    fileprivate func saveData(_ responseStr:String?){
        
        if let response = responseStr {
            let fileName = NSHomeDirectory() + "/Documents/creditdata.bin"
            
            do {
                try response.write(toFile: fileName, atomically: true, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("Save credit data to file fail due to \(error)!!!!!!!!!!!!")
            }
        }
    }
}
