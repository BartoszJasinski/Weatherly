//
// Created by ITT on 07/06/2022.
//

import ObjectMapper

class Location: Mappable {
    var key: String?
    var localizedName: String?
    var country: Country?
    var countryName: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        key <- map["Key"]
        localizedName <- map["LocalizedName"]
        country <- map["Country"]
        countryName <- map["Country.LocalizedName"]
    }
}