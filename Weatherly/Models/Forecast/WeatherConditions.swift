//
// Created by ITT on 07/06/2022.
//

import ObjectMapper

class WeatherConditions: Mappable {
    var date: String?
    var temperature: TemperatureForecast?
    var iconPhrase: String?
    var hasPrecipitation: Bool?
    var precipitationType: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        date <- map["Date"]
        temperature <- map["Temperature"]
        iconPhrase <- map["IconPhrase"]
        hasPrecipitation <- map["HasPrecipitation"]
        precipitationType <- map["PrecipitationType"]
    }
}