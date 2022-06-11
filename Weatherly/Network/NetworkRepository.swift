//
// Created by ITT on 04/06/2022.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper
import UIKit

public class NetworkRepository {
    var disposeBag: DisposeBag = DisposeBag()
    let baseURL = URL(string: "https://api.printful.com/countries")!
    var method = RequestType.GET
    var parameters = [String: String]()

    private static let BASE_PATH = "https://dataservice.accuweather.com/"
    private static let API_VERSION = "/v1/"
//    private static let API_KEY = "GIATuLsLemzJHcDfEAawtS33wjCY4IXp"
//    private static let API_KEY = "KumZMHHA9GKHh8S8N7CqtUvEV8bI5lmg"
//    private static let API_KEY = "AWXEs1NcvKIXOvzgGIFWWMGAex2qkHnG"
//    private static let API_KEY = "9GbgJxFuBCIwEIj9K3VSsjrzwd1SVLXX"
    private static let API_KEY = "AEczK8HNw5a5ACYUvAdxmMNu0AfF4IgI"

    func request(with baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }



//    func parseJsonNews() {
//        DispatchQueue.main.async {
//            Alamofire.request("link request", method: .get).responseJSON { (response) in
//                switch response.result {
//                case .success(let value):
//                    let news = [value]
//                    print(news) // here in console it prints correctly the json, starting with [<__NSArrayI 0x6000001a9e60 ....
//                    for new in news {
//                        let title = new["title"]
//                        print(title)
//                    }
//                    print(newsss)
//
//                    self.tableView.reloadData()
//                case.failure(let error):
//                    print(error.localizedDescription)
//                }
//            })
//        }
//    }

    //TODO: ADD PARAMS
    static func getCitiesMatchingName(city: String) -> Observable<[Location]> {
        RxAlamofire.json(.get, "\(BASE_PATH)/locations\(API_VERSION)cities/autocomplete?apikey=\(API_KEY)&q=\(String(describing: city.urlEncoding))")
                .mapArray(type: Location.self)
    }

    static func getCurrentWeather(cityId: String) -> Observable<[CurrentConditions]>
    {
        RxAlamofire.json(.get, "\(BASE_PATH)/currentconditions\(API_VERSION)\(cityId)?apikey=\(API_KEY)&metric=true")
                .mapArray(type: CurrentConditions.self)
    }

    static func getHourlyForecast(cityKey: String) -> Observable<[HourForecast]> {
        RxAlamofire.json(.get, "\(BASE_PATH)/forecasts\(API_VERSION)hourly/12hour/\(cityKey)?apikey=\(API_KEY)&metric=true")
                .mapArray(type: HourForecast.self)
    }

    static func getDailyForecast(cityKey: String) -> Observable<DayForecast> {//
        RxAlamofire.json(.get, "\(BASE_PATH)/forecasts\(API_VERSION)daily/5day/\(cityKey)?apikey=\(API_KEY)&metric=true")
                .mapObject(type: DayForecast.self)
    }

}