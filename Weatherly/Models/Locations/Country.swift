//
// Created by ITT on 07/06/2022.
//

import ObjectMapper

struct Country {
    var id: String?
    var localizedName: String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id <- map["ID"]
        localizedName <- map["LocalizedName"]
    }

}
