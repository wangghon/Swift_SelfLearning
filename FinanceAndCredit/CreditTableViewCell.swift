//
//  CreditTableViewCell.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/17.
//  Copyright © 2016年 whb. All rights reserved.
//

import UIKit

let kCreditPaddingHeight : CGFloat = 12.0

class CreditTableViewCell: UITableViewCell {
    
    var isFirstRow: Bool = false 
    var responseTap: Bool = false
    var topPaddingHeight: Float = 0.0
    var bottomPaddingHeight: Float = 0.0
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
