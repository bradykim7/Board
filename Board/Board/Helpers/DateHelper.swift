//
//  DateHelpers.swift
//  Board
//
//  Created by Minseok Brady Kim on 5/18/24.
//

import Foundation

class DateHelper {
    static func formatDateString(_ dateString: String, from inputFormat: String, to outputFormat: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = outputFormat
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    static func isWithin24Hours(dateString: String, format: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        guard let date = formatter.date(from: dateString) else {
            return false
        }
        
        let currentDate = Date()
        let timeInterval = currentDate.timeIntervalSince(date)
        return timeInterval <= 24 * 60 * 60
    }
}
