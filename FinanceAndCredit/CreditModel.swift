//
//  CreditModel.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/12.
//  Copyright © 2016年 whb. All rights reserved.
//

import Foundation
import SwiftyJSON

let kContent = "content";
let kCredit = "app_youqianhua";
let kCreditFingerPrint = "fingerprint";
let kCreditData = "data";
let kCreditDataType = "group_type";
let kCreditContent = "content";
let kCreditUrlIosPrefix = "ios_prefix";
let kCreditItemList = "list";
let kCreditTitle = "title";
let kCreditLinkType = "type";
let kCreditLinkUrl = "link_addr";
let kCreditHasCorner = "has_corner";
let kCreditCornerURL = "corner_addr";
let kCreditImgUrl = "logo";

let kCreditHeaderModelType = "201"
let kCreditAdModelType = "202"


open class CreditModel {
    
    let fingerPrint:String?
    var urlPrefix:String?
    
    let groupTypeArray:Array<String>?
    let dataArray:Array<AnyObject>?
    
    public init?(json: JSON) {
        
        fingerPrint = json[kContent][kCredit][kCreditFingerPrint].stringValue
        urlPrefix = json[kContent][kCreditUrlIosPrefix].stringValue

        //create data list based on the type
        var tempTypeList = [String]()
        var tempDataList = [AnyObject]()
        
        if let dataJson = json[kContent][kCredit][kCreditData].array {
            for (_, item) in dataJson.enumerated() {
                
                if let type = item[kCreditDataType].string {
                    switch type {
                    case kCreditAdModelType:
                        let adModel = CreditAdModel(json:item)
                        adModel?.addUrlPrefix(urlPrefix)

                        tempDataList.append(adModel!)
                        tempTypeList.append(String(type))
                        
                    case kCreditHeaderModelType:
                        let headerModel = CreditHeaderModel(json:item)
                        
                        tempDataList.append(headerModel!)
                        tempTypeList.append(String(type))
                    default:
                        break
                    }
                }
            }
        }
        groupTypeArray = tempTypeList
        dataArray = tempDataList
    }
}

open class CreditHeaderItem {
    
    let title : String
    let link_type : UInt
    let link_addr : String
    
    public init?(json:JSON) {
        title = json[kCreditTitle].stringValue
        link_addr = json[kCreditLinkUrl].stringValue
        link_type = json[kCreditLinkType].uIntValue
    }
}

open class CreditHeaderModel {
    
    var headerItems = [CreditHeaderItem]()
    let groupType:String?
    
    public init?(json:JSON) {
        groupType = json[kCreditDataType].string
        
        if let listJson = json[kCreditItemList].array {
            for (_, item) in listJson.enumerated() {
                
                if let headerItem  = CreditHeaderItem(json: item) {
                    headerItems.append(headerItem)
                }
            }
        }
    }
}

open class CreditAdItem {
    
    let title: String
    var image_url: String
    let link_addr:String
    var corner_url:String
    
    let link_type:UInt
    let  has_corner:Bool
    
    public init?(json: JSON) {
        title = json[kCreditTitle].stringValue
        image_url = json[kCreditImgUrl].stringValue
        link_addr = json[kCreditLinkUrl].stringValue
        corner_url = json[kCreditCornerURL].stringValue
        
        link_type = json[kCreditLinkType].uIntValue
        has_corner = json[kCreditHasCorner].boolValue
    }
    
     func addUrlPrefix(_ urlPrefix:String?) {
        if let prefix = urlPrefix {
            if (image_url.characters.count > 0) {
                image_url = prefix + image_url
            }
            
            if (corner_url.characters.count > 0) {
                corner_url = prefix + corner_url
            }
        }
    }
}

open class CreditAdModel {
    
    var adItemList: [CreditAdItem]? = []
    
    public init?(json: JSON) {
        if let listJson = json[kCreditItemList].array {
            for (_, item) in listJson.enumerated() {
            
                if let adItem  = CreditAdItem(json: item) {
                    adItemList?.append(adItem)
                }
            }
        }
    }
    
    open func addUrlPrefix(_ urlPrefix:String?) {
        if let prefix = urlPrefix {
            if let itemList = adItemList {
                for (_, item) in itemList.enumerated() {
                    item.addUrlPrefix(prefix)
                }
            }
        }
    }
}

