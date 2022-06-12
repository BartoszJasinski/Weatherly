//
// Created by ITT on 09/06/2022.
//

import Foundation

import ObjectMapper

class CurrentConditions: Mappable {
    var weatherText: String?
    var hasPrecipitation: Bool?
    var precipitationType: String?
    var temperature: CurrentTemperature?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        weatherText <- map["WeatherText"]
        hasPrecipitation <- map["HasPrecipitation"]
        precipitationType <- map["PrecipitationType"]
        temperature <- map["Temperature"]
    }
}