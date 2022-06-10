//
// Created by ITT on 07/06/2022.
//

import ObjectMapper

class WeatherConditions: Mappable {
    var date: String?
    var temperature: TemperatureForecast?
    var hasPrecipitation: Bool?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        date <- map["Date"]
        temperature <- map["Temperature"]
        hasPrecipitation <- map["HasPrecipitation"]
    }
}