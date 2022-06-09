//
// Created by ITT on 07/06/2022.
//

import ObjectMapper

class Country {
    var id: String?
    var localizedName: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["ID"]
        localizedName <- map["LocalizedName"]
    }

}
