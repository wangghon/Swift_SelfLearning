//
//  CreditTableViewAdCell.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/17.
//  Copyright © 2016年 whb. All rights reserved.
//

import UIKit
import Kingfisher

let kCreditPaddingWidth  : CGFloat = 14.0
let kCreditCornerWH :CGFloat = 36

class CreditTableViewAdCell: CreditTableViewCell {
    
    var hasCorner:Bool = false {
        didSet {
            if (!hasCorner) {
                cornerView.image = nil;
            }
        }
    }
    
    var cornerImageUrl = String() {
        didSet {
            if (cornerImageUrl.characters.count > 0) {
                cornerView.kf.setImage(with: URL(string: cornerImageUrl), placeholder: cornerView.image, options: nil, progressBlock: nil, completionHandler: nil)

            } else {
                cornerView.image = nil
            }
        }
    }
    var bgImageUrl = String(){
        didSet {
            if (bgImageUrl.characters.count > 0) {
                bgView.kf.setImage(with: URL(string: bgImageUrl), placeholder: bgView.image, options: nil, progressBlock: nil, completionHandler: nil)

            } else {
                bgView.image = nil
            }
        }
    }

    lazy var bgView : UIImageView = {
        let lBgView = UIImageView()
        lBgView.backgroundColor = UIColor.clear
        lBgView.layer.cornerRadius = 2;
        return lBgView
    }()
    var cornerView : UIImageView = {
        let lcornerView = UIImageView()
        lcornerView.backgroundColor = UIColor.clear
        lcornerView.layer.cornerRadius = 2;
        return lcornerView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(valueRGB: 0xf5f5f5)
        
        contentView.addSubview(bgView)
        contentView.addSubview(cornerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bgX : CGFloat = kCreditPaddingWidth
        let bgY : CGFloat = isFirstRow ? kCreditPaddingHeight : 0.0
        let bgW : CGFloat = contentView.bounds.size.width - 2 * kCreditPaddingWidth
        let bgH : CGFloat = contentView.bounds.size.height - bgY - kCreditPaddingHeight
        
        bgView.frame = CGRect(x: bgX, y: bgY, width: bgW, height: bgH)
        

        let cornerX = contentView.bounds.size.width - kCreditPaddingWidth - kCreditCornerWH

        cornerView.frame = CGRect(x: cornerX, y: bgY, width: kCreditCornerWH, height: kCreditCornerWH)
    }

}
