//
//  DateFormatTransform.swift
//  NextMovie
//
//  Created by Luís Wolf on 28/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation
import ObjectMapper

open class DateFormatTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = Double
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateText = value as? String {
            DateHelper.sharedInstance.formatter.dateFormat = "yyyy-MM-dd"
            return DateHelper.sharedInstance.formatter.date(from: dateText)
        }
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            DateHelper.sharedInstance.formatter.dateFormat = "yyyy-MM-dd"
            return DateHelper.sharedInstance.formatter.string(from: date)
        }
        return nil
    }
    
    public func transformToJSON(_ value: Date?) -> Double? {
        return nil
    }
}
