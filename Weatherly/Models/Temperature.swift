//
// Created by ITT on 09/06/2022.
//

import Foundation
import ObjectMapper

class Temperature: Mappable {
    var value: Double?
    var valueFormatted = ""
    var unit: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        value <- map["Value"]
        value?.round()

        valueFormatted = value?.temperatureFormat ?? ""

        unit <- map["Unit"]
    }

}