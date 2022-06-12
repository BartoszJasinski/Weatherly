//
// Created by ITT on 07/06/2022.
//

import ObjectMapper
import CoreData

class Location: Mappable {
    var key: String?
    var localizedName: String?
    var country: Country?
    var countryName: String?

    init(managedObject: NSManagedObject) {
        key = managedObject.value(forKey: CoreDataUtils.Constants.key) as? String
        localizedName = managedObject.value(forKey: CoreDataUtils.Constants.localizedName) as? String
        country = nil
        countryName = managedObject.value(forKey: CoreDataUtils.Constants.countryName) as? String
    }

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        key <- map["Key"]
        localizedName <- map["LocalizedName"]
        country <- map["Country"]
        countryName <- map["Country.LocalizedName"]
    }
}