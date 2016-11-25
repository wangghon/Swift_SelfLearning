//
//  CreditViewController.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/10.
//  Copyright © 2016年 whb. All rights reserved.
//

import Foundation

import UIKit

let kCreditNavigationBarHeight = CGFloat(64.0)
let kCreditHeaderViewHeight = CGFloat(148.0)
let kCreidtControllerWidth = UIScreen.main.bounds.width

class CreditViewController: UIViewController, UITableViewDelegate, CreditDataHandlingDelegate {
    
    lazy var headerView:CreditHeaderView = {
        
        let header = CreditHeaderView()
        
        let headerWidth:CGFloat = UIScreen.main.bounds.width
        let headerHeight:CGFloat = kCreditHeaderViewHeight
        header.frame = CGRect(x: 0,y: 0, width: headerWidth, height: headerHeight)
        
        header.backgroundColor = UIColor(valueRGB: kHeaderRedColor)
        header.isUserInteractionEnabled = true
        return header
    }()
    lazy var tableView:UITableView = {
        
        let tableWidth:CGFloat = kCreidtControllerWidth
        let tableHeight:CGFloat = UIScreen.main.bounds.height
        let frame =  CGRect(x: 0, y: 0, width: tableWidth, height: tableHeight)
        let table = UITableView(frame:frame)
        table.dataSource = self.viewModel
        table.delegate = self
        
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = UIColor(valueRGB: 0xeeeeee)
    
        return table
    }()
    
    var viewModel = CreditViewModel()
    var dataManager : CreditDataProtocol?
    
    
    convenience init(dataManager:CreditDataProtocol?) {
        
        self.init(nibName:nil, bundle:nil)
        
        if let dataMgr = dataManager {
            
            self.dataManager = dataMgr
            
            self.dataManager!.delegate = self
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(tableView)
        
        tableView.tableHeaderView = headerView
        
        tableView.register(CreditTableViewAdCell.self, forCellReuseIdentifier: kCreditCellAdClassName)
        
        self.view.backgroundColor = UIColor(valueRGB: 0xf5f5f5)
        dataManager?.updateLocalData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        dataManager?.updateRemoteData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let urlString = viewModel.tableViewItems[(indexPath as NSIndexPath).row].cellJumpUrl {
            let webVC = WebViewController.createWebVCWithURL(urlString)
            
            self.navigationController?.pushViewController(webVC, animated: true)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item:CreditTableViewItem = viewModel.tableViewItems[(indexPath as NSIndexPath).row]
        
        return item.cellheight
    }
    
    func didParseData(_ dataManager: CreditDataProtocol, dataModel: CreditModel, error: NSError?) {
       
        if error != nil {
            
        } else {
            viewModel.updateData(dataModel)
            
            updateHeaderView()
            tableView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func updateHeaderView() {
        headerView.title = viewModel.headerTitle
        headerView.canJump = viewModel.headerLinkUrl.characters.count > 0 && viewModel.headerTitle.characters.count > 0
    }
    
}

