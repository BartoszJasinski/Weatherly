//
// Created by ITT on 09/06/2022.
//

import Foundation
import ObjectMapper

class TemperatureForecast: Mappable {
    var minimum: Temperature?
    var maximum: Temperature?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        minimum <- map["Minimum"]
        maximum <- map["Maximum"]
    }

}
