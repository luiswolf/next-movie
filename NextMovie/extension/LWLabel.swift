//
//  LWLabel.swift
//  NextMovie
//
//  Created by Luís Wolf on 26/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

@IBDesignable
class LWLabel: UILabel {
    fileprivate var fontName: UIFont = UIFont.text
    
    @IBInspectable
    var fontColor: UIColor = UIColor.black {
        didSet {
            textColor = fontColor
        }
    }
    
    @IBInspectable
    var isDisplay: Bool = false {
        didSet {
            fontName = isDisplay ? UIFont.display : UIFont.text
        }
    }
    
    @IBInspectable 
    var isBold: Bool = false {
        didSet {
            fontName = isBold ? UIFont.textSemibold : UIFont.text
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        textColor = fontColor
        font = fontName.withSize(font.pointSize)
    }
}
