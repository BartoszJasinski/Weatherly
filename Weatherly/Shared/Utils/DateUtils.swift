//
// Created by ITT on 09/06/2022.
//

import Foundation

struct DateUtils {

    static func getComponentOutOfDate(dateText: String, component: Calendar.Component) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: dateText)!

        return "\(Calendar.current.component(component, from: date)):00"
    }
}