//
// Created by ITT on 07/06/2022.
//

import RxSwift
import RxRelay

class MainViewModel {
    public let locationsArray: BehaviorRelay<[Location]> = BehaviorRelay(value: [])
    private let disposeBag = DisposeBag()

    func getListOfCities(city: String) {
        NetworkService.getCitiesMatchingName(city: city).subscribe(onNext: { [self] locations in locationsArray.accept(locations)})
                .disposed(by: disposeBag)
    }

    func saveLocation(row: Int) {
        CoreDataUtils.singleton.saveUnique(location: locationsArray.value[row])
    }

    func getSearchHistory() {
        guard let searchHistory = CoreDataUtils.singleton.fetch() else { return }
        locationsArray.accept(searchHistory)
    }
}