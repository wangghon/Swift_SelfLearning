//
//  CreditHeaderView.swift
//  FinanceAndCredit
//
//  Created by HB on 16/8/10.
//  Copyright © 2016年 whb. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class CreditHeaderView: UIView {
    
    var title = String("") {
        didSet {
            
            if (title == titleLabel.text) {
                return
            }
            
            if title?.characters.count > 0 {
                titleLabel.text = title
            } else {
                titleLabel.text = kCreditStringDefinedSlogon
            }
            
            self.setNeedsLayout()
        }
    }
    
    var canJump = false {

        didSet {
            if (containerBtn.isUserInteractionEnabled == canJump) {
                return
            }
            
            containerBtn.isUserInteractionEnabled = canJump
            jumpImage.isHidden = !canJump
            
            self.setNeedsLayout()
        }
    }
    
    lazy var jumpImage: UIImageView = {
        let jumpImg = UIImageView()
        jumpImg.backgroundColor = UIColor.clear
        
        jumpImg.image = UIImage(named:"credit_jump")
        return jumpImg
    }()
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        
        label.backgroundColor = UIColor.clear
        label.font =  UIFont.systemFont(ofSize: 12.0)
        label.textColor = UIColor(valueRGB: 0xffffff, alpha: 0.7)
        label.textAlignment = .center
        label.text = kCreditStringDefinedSlogon
        
        return label
    }()
    
    lazy var containerBtn: UIButton = {
        let btn = UIButton(type:.custom)
        
        btn.backgroundColor = UIColor.clear
        btn.isExclusiveTouch = true
        btn.clipsToBounds = true

        btn.addTarget(self, action: #selector(touchUp), for:
        [.touchUpInside, .touchUpOutside, .touchCancel] )
        btn.addTarget(self, action: #selector(touchDown), for: .touchDown)
        return btn
    }()
    
    lazy var logoView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "credit_nav_logo")
        
        logo.contentMode = .scaleAspectFit
        
        return logo
    }()
    
    lazy var topView: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = UIColor(valueRGB:kHeaderRedColor)
        
        return view
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        
        let bgView = UIImageView()
        bgView.image = UIImage(named: "credit_nav_bg")
        
        self.addSubview(bgView)
        
        bgView.frame = self.bounds
        
        self.addSubview(logoView)
        self.addSubview(containerBtn)
        containerBtn.addSubview(titleLabel)
        containerBtn.addSubview(jumpImage)
        self.addSubview(topView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        let topH: CGFloat = UIScreen.main.bounds.height;
        let topW: CGFloat = self.bounds.width;
        
        topView.frame = CGRect(x: 0, y: -topH, width: topW, height: topH)
        
        let logoY: CGFloat = 56.0
        let logoW = logoView.image!.size.width
        let logoH = logoView.image!.size.height
        let logoX = (UIScreen.main.bounds.size.width - logoW) / 2.0
        logoView.frame = CGRect(x: logoX, y: logoY, width: logoW, height: logoH);
        
        let size = titleLabel.attributedText?.size()
        let deltaWidth: CGFloat = canJump ? (jumpImage.image!.size.width + 3.0) : (0.0);
        let width = size?.width > 264.0 ? 264.0 : size!.width + deltaWidth
        
        let btnX: CGFloat = (UIScreen.main.bounds.size.width - width) / 2.0
        let btnY: CGFloat = 97.0
        let btnW: CGFloat = width
        let btnH: CGFloat = 22.0
        containerBtn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
        
        let titleW:CGFloat = size!.width
        titleLabel.frame = CGRect(x: 0, y: 0, width: titleW, height: btnH)
        
        if (containerBtn.isUserInteractionEnabled) {
            let imgX: CGFloat = titleW + 3.0
            let imgY: CGFloat = (btnH - jumpImage.image!.size.height) / 2.0
             jumpImage.frame  = CGRect(x: imgX, y: imgY,width: jumpImage.image!.size.width,height: jumpImage.image!.size.height)
        } else {
            jumpImage.frame = CGRect.zero;
        }
    }

    func touchUp(_ sender:UIButton) {
        titleLabel.alpha = 1.0
        jumpImage.alpha = 1.0
    }
    
    func touchDown(_ sender:UIButton) {
        titleLabel.alpha = 0.5
        jumpImage.alpha = 0.5
    }
}
