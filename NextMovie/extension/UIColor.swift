//
//  UIColor.swift
//  EventGuideApp
//
//  Created by Luís Wolf on 17/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import UIKit

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        if self > range.upperBound {
            return range.upperBound
        } else if self < range.lowerBound {
            return range.lowerBound
        } else {
            return self
        }
    }
}

extension UIColor {
    static let red = #colorLiteral(red: 0.768627451, green: 0.01568627451, blue: 0.01568627451, alpha: 1)
    static let black = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
    static let green = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    static let gray = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    static let white = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
    
    public func lighter(by percentage: CGFloat = 50.0) -> UIColor {
        return self.adjustBrightness(by: abs(percentage))
    }
    public func darker(by percentage: CGFloat = 50.0) -> UIColor {
        return self.adjustBrightness(by: -abs(percentage))
    }
    func adjustBrightness(by percentage: CGFloat = 50.0) -> UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let pFactor = (100.0 + percentage) / 100.0
            
            let newRed = (red * pFactor).clamped(to: 0.0 ... 1.0)
            let newGreen = (green * pFactor).clamped(to: 0.0 ... 1.0)
            let newBlue = (blue * pFactor).clamped(to: 0.0 ... 1.0)
            
            return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
        }
        
        return self
    }
}
