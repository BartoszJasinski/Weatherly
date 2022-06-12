//
// Created by ITT on 09/06/2022.
//

import ObjectMapper

struct TemperatureForecast: Mappable {
    var minimum: Temperature?
    var maximum: Temperature?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        minimum <- map["Minimum"]
        maximum <- map["Maximum"]
    }

}
