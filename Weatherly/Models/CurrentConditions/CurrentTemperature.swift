//
// Created by ITT on 09/06/2022.
//

import Foundation
import ObjectMapper

class CurrentTemperature: Mappable {
    var metric: Temperature?
    var imperial: Temperature?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        metric <- map["Metric"]
        imperial <- map["Imperial"]
    }

}
