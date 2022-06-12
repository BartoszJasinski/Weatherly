//
// Created by ITT on 07/06/2022.
//

import ObjectMapper

struct DayForecast: Mappable {
    var dailyForecasts: [WeatherConditions]?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        dailyForecasts <- map["DailyForecasts"]
    }
}
