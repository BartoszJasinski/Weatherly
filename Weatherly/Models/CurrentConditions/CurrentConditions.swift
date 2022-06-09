//
// Created by ITT on 09/06/2022.
//

import Foundation

import ObjectMapper

class CurrentConditions: Mappable {
    var temperature: CurrentTemperature?
    var hasPrecipitation: Bool?
    var weatherText: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        temperature <- map["Temperature"]
        hasPrecipitation <- map["HasPrecipitation"]
        weatherText <- map["WeatherText"]
    }
}