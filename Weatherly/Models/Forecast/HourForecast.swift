//
// Created by ITT on 09/06/2022.
//

import ObjectMapper

class HourForecast: Mappable {
    var dateTime: String?
    var temperature: Temperature?
    var hasPrecipitation: Bool?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        dateTime <- map["DateTime"]
        temperature <- map["Temperature"]
        hasPrecipitation <- map["HasPrecipitation"]
    }
}