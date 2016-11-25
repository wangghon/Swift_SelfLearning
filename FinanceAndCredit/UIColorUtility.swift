//
//  UIColorUtility.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/11.
//  Copyright © 2016年 whb. All rights reserved.
//

import Foundation
import UIKit

let kHeaderRedColor = UInt(0xe65757)
let kBackgroundGrayColor = UInt(0xF5F5F5)
let kTableBGGrayColor = UInt(0xeeeeee)

extension UIColor {
    convenience init(valueRGB: UInt) {
        self.init(valueRGB: valueRGB, alpha: CGFloat(1.0))
    }
    convenience init(valueRGB: UInt, alpha:CGFloat) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}
