//
// Created by ITT on 09/06/2022.
//

import ObjectMapper

struct CurrentTemperature: Mappable {
    var metric: Temperature?
    var imperial: Temperature?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        metric <- map["Metric"]
        imperial <- map["Imperial"]
    }

}
