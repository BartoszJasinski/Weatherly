//
// Created by ITT on 09/06/2022.
//

import Foundation
import ObjectMapper

class Temperature: Mappable {
    var value: Double?
    var unit: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        value <- map["Value"]
        unit <- map["Unit"]
    }

}