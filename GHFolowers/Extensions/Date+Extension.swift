//
//  Date+Extension.swift
//  GHFolowers
//
//  Created by Igor Tokalenko on 13.01.2025.
//
import Foundation

extension Date {
    
    // Function to convert a date string to a specific format
    static func fromISOStringToDate(_ isoString: String) -> Date? {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Input format of the ISO string
        return isoFormatter.date(from: isoString)
    }
    
    // Function to convert the date into "DD.month.YYYY" format
    func toCustomFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy" // Output format (e.g., "26.April.2009")
        dateFormatter.locale = Locale(identifier: "en_US") // Ensure English month names
        return dateFormatter.string(from: self)
    }
}
