//
// Created by ITT on 12/06/2022.
//

import UIKit
import CoreData

// SINGLETON DESIGN PATTERN IN ORDER TO CREATE locationEntity and locationManaged ONLY ONCE
//FIXME: GET RID OF ENTITY DUPLICATES
struct CoreDataUtils {
    static let singleton = CoreDataUtils()

    let managedContext: NSManagedObjectContext?
    let locationEntity: NSEntityDescription?
    let locationManaged: NSManagedObject?

    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else {
            managedContext = nil
            locationEntity = nil
            locationManaged = nil

            return
        }

        managedContext = appDelegate.persistentContainer.viewContext
        locationEntity = NSEntityDescription.entity(forEntityName: Constants.locationEntity, in: managedContext!)!
        locationManaged = NSManagedObject(entity: locationEntity!, insertInto: managedContext)
    }

    func saveUnique(location: Location) {
        if (fetch()?.contains { $0.key == location.key }) ?? false { return }

        locationManaged!.setValue(location.key, forKeyPath: Constants.key)
        locationManaged!.setValue(location.localizedName, forKeyPath: Constants.localizedName)
        locationManaged!.setValue(location.countryName, forKeyPath: Constants.countryName)

        do {
            try managedContext!.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetch() -> [Location]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.locationEntity)

        do {
            return populateArray(managedObjects: try managedContext!.fetch(fetchRequest))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        return nil
    }

    // I THINK WE COULD MAKE IT GENERIC BUT FOR THE SAKE OF SIMPLICITY I MADE IT ABLE TO HANDLE ONLY [NSManagedObject] -> [Location]
    func populateArray(managedObjects: [NSManagedObject]) -> [Location] {
        managedObjects.map{ (Location(managedObject: $0)) }
    }

}

extension CoreDataUtils {
    enum Constants {
        static let locationEntity = "LocationEntity"
        static let key = "key"
        static let localizedName = "localizedName"
        static let countryName = "countryName"
    }
}