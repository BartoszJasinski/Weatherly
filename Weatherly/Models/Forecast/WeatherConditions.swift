//
// Created by ITT on 07/06/2022.
//

import ObjectMapper

class WeatherConditions: Mappable {
    var temperature: TemperatureForecast?
    var hasPrecipitation: Bool?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        temperature <- map["Temperature"]
        hasPrecipitation <- map["HasPrecipitation"]
    }
}