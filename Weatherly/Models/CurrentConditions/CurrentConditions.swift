//
// Created by ITT on 09/06/2022.
//

import ObjectMapper

struct CurrentConditions: Mappable {
    var weatherText: String?
    var hasPrecipitation: Bool?
    var precipitationType: String?
    var temperature: CurrentTemperature?

    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        weatherText <- map["WeatherText"]
        hasPrecipitation <- map["HasPrecipitation"]
        precipitationType <- map["PrecipitationType"]
        temperature <- map["Temperature"]
    }
}