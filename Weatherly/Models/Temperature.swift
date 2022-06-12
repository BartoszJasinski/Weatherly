//
// Created by ITT on 09/06/2022.
//

import Foundation
import ObjectMapper

struct Temperature: Mappable {
    var value: Double?
    var valueFormatted = ""
    var unit: String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        value <- map["Value"]
        value?.round()

        valueFormatted = value?.temperatureFormat ?? ""

        unit <- map["Unit"]
    }

}