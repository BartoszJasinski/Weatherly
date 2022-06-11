//
// Created by ITT on 11/06/2022.
//

import Foundation

extension Date {
    static func formatDate(dateText: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return dateFormatter.date(from: dateText)!
    }

    static func getComponentOutOfDate(dateText: String, component: Calendar.Component) -> String {
        "\(Calendar.current.component(component, from: formatDate(dateText: dateText)))"
    }

    static func getWeekDay(dateText: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"

        return dateFormatter.string(from: formatDate(dateText: dateText)).capitalized
    }
}