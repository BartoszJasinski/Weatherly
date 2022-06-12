//
// Created by ITT on 09/06/2022.
//

import ObjectMapper

class HourForecast: Mappable {
    var dateTime: String?
    var temperature: Temperature?
    var iconPhrase: String?
    var hasPrecipitation: Bool?
    var precipitationType: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        dateTime <- map["DateTime"]
        temperature <- map["Temperature"]
        iconPhrase <- map["IconPhrase"]
        hasPrecipitation <- map["HasPrecipitation"]
        precipitationType <- map["PrecipitationType"]
    }
}