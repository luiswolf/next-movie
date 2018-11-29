//
//  DateHelper.swift
//  NextMovie
//
//  Created by Luís Wolf on 25/11/2018.
//  Copyright © 2018 Luís Wolf. All rights reserved.
//

import Foundation

class DateHelper {
    let formatter = DateFormatter()
    static let sharedInstance = DateHelper()
    
    private init() {
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        if let locale = Locale.preferredLanguages.first {
            formatter.locale = Locale(identifier: locale)
        }
    }
    
    func getFormattedDate(from date: Date) -> String {
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
