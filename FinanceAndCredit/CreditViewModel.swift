//
//  CreditViewModel.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/17.
//  Copyright © 2016年 whb. All rights reserved.
//

import UIKit

let kCreditCellAdClassName = "CreditTableViewAdCell"
let kCreditTableViewAdCellHeight = CGFloat(165.0)

struct CreditTableViewItem {
    var cellheight = CGFloat(0)
    var cellData: AnyObject?
    var cellLinkType: String?
    var cellJumpUrl: String?
    var cellClassName: String?
    var cellGroupType: String?
    var cellName:String?
    
}

open class CreditViewModel: NSObject, UITableViewDataSource {
    
    var tableViewItems: [CreditTableViewItem]
    var totalTableViewCount: Int {
        get { return tableViewItems.count }
    }
    
    var headerTitle = String()
    var headerLinkUrl = String()
    var headerLinkType = UInt(0)
    
    override init() {
        tableViewItems = [CreditTableViewItem]()
        
        super.init()
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier: String = tableCellIdentifier((indexPath as NSIndexPath).row)
        
        let cell: UITableViewCell = createTableViewCell(tableView, cellID: cellIdentifier)
        
        let item: CreditTableViewItem = tableViewItems[(indexPath as NSIndexPath).row]
        
        updateTableViewCell(cell, item: item, row: (indexPath as NSIndexPath).row)
        
        return cell
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalTableViewCount
    }
    
    
    open func updateData(_ data:CreditModel?) -> Bool {
        guard let newData = data else { return false }
        
        guard let groupTypeArray = newData.groupTypeArray else { return false }
        
        tableViewItems = [CreditTableViewItem]()
        
        for (i, item) in groupTypeArray.enumerated() {
            switch item {
            case kCreditAdModelType:
                guard let newAdData = newData.dataArray![i] as? CreditAdModel else { return false }
                updateAdCellData(newAdData)
            case kCreditHeaderModelType:
                guard let newHeaderData = newData.dataArray![i] as? CreditHeaderModel else { return false }
                updateHeaderData(newHeaderData)
            default:
                break
            }
        }
        return true
    }
    
    fileprivate func tableCellIdentifier(_ row:Int) -> String {
        let item = tableViewItems[row]
        return item.cellClassName!
    }
    
    fileprivate func createTableViewCell(_ tableView:UITableView, cellID:String) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        guard let newCell = cell
            else {
                let cellClass = NSClassFromString(cellID) as? UITableViewCell.Type
                cell = cellClass?.init(style: .default, reuseIdentifier:cellID)
                return cell!
        }
        
        return newCell
    }
    
    fileprivate func updateTableViewCell(_ cell: UITableViewCell, item:CreditTableViewItem, row:Int) {
        
        let adCell = cell as! CreditTableViewAdCell
        
        adCell.isFirstRow = row == 0 ? true : false
        
        updateAdCell(adCell, item: item.cellData as! CreditAdItem)
        
        if let jumpUrl = item.cellJumpUrl {
            adCell.responseTap = jumpUrl.characters.count > 0
        } else {
            adCell.responseTap = false
        }
    }
    
    
    fileprivate func updateAdCell(_ cell: CreditTableViewAdCell, item:CreditAdItem) {
        
        cell.bgImageUrl = item.image_url
        cell.hasCorner = item.has_corner
        cell.cornerImageUrl = item.corner_url
    }
    
    fileprivate func updateAdCellData(_ adData: CreditAdModel?) {
        
        guard let data = adData else { return }
        
        var tempList = [CreditTableViewItem]()
        
        let headPaddingHeight = tableViewItems.count > 0 ? 0:kCreditPaddingHeight
        
        guard let adItemList = data.adItemList else { return }
        
        for (i, item) in adItemList.enumerated() {
            var cellItem = CreditTableViewItem()
            
            cellItem.cellClassName = kCreditCellAdClassName
            cellItem.cellheight = kCreditTableViewAdCellHeight + kCreditPaddingHeight + (i == 0 ? headPaddingHeight:0)
            cellItem.cellJumpUrl = item.link_addr
            cellItem.cellName = item.title
            cellItem.cellData = item
            tempList.append(cellItem)
        }
        if (tableViewItems.count == 0) {
            tableViewItems = tempList
        } else {
            tableViewItems += tempList
        }
        
    }
     
    fileprivate func updateHeaderData(_ headerData: CreditHeaderModel) {
        
        if headerData.headerItems.count == 0 { return }
        
        let newHeader:CreditHeaderItem = headerData.headerItems[0]
        
        headerTitle = newHeader.title
        headerLinkUrl = newHeader.link_addr
        headerLinkType = newHeader.link_type
    }
}
