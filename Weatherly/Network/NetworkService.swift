//
// Created by ITT on 04/06/2022.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire
import ObjectMapper
import UIKit

struct NetworkService {
    //TODO: CHECK FOR HTTP ERRORS
    private static let BASE_URL = "https://dataservice.accuweather.com/"
    private static let API_VERSION = "v1/"

//    private static let API_KEY = "GIATuLsLemzJHcDfEAawtS33wjCY4IXp"
//    private static let API_KEY = "KumZMHHA9GKHh8S8N7CqtUvEV8bI5lmg"
    private static let API_KEY = "AWXEs1NcvKIXOvzgGIFWWMGAex2qkHnG"
//    private static let API_KEY = "9GbgJxFuBCIwEIj9K3VSsjrzwd1SVLXX"
//    private static let API_KEY = "AEczK8HNw5a5ACYUvAdxmMNu0AfF4IgI"
//    private static let API_KEY = "N8TOmpbSKJB1GV43PEO7cJUMl32T7aBu"

    // MARK: URL ENDPOINTS
    private static let locations = "locations/"
    private static let currentConditions = "currentconditions/"
    private static let forecasts = "forecasts/"
    private static let cities = "cities/autocomplete"
    private static let hourly = "hourly/12hour/"
    private static let daily = "daily/5day/"

    // MARK: URL PARAM NAMES
    private static let apiKeyUrlParam = "apikey"
    private static let citiesQParam = "q"
    private static let metricParam = "metric"

    // MARK: URL QUERY ITEMS
    private static let apiKeyQueryItem = URLQueryItem(name: apiKeyUrlParam, value: API_KEY)
    private static let metricQueryItem = URLQueryItem(name: metricParam, value: "true")


    static func getCitiesMatchingName(city: String) -> Observable<[Location]> {
        var urlComponents = URLComponents(string: "\(BASE_URL)\(locations)\(API_VERSION)\(cities)")!
        urlComponents.queryItems = [
            apiKeyQueryItem,
            URLQueryItem(name: citiesQParam, value: city)
        ]

        return RxAlamofire.json(.get, urlComponents).mapArray(type: Location.self)
    }

    static func getCurrentWeather(cityId: String) -> Observable<[CurrentConditions]>
    {
        var urlComponents = URLComponents(string: "\(BASE_URL)\(currentConditions)\(API_VERSION)\(cityId)")!
        urlComponents.queryItems = [
            apiKeyQueryItem,
            metricQueryItem
        ]

        return RxAlamofire.json(.get, urlComponents).mapArray(type: CurrentConditions.self)
    }

    static func getHourlyForecast(cityKey: String) -> Observable<[HourForecast]> {
        var urlComponents = URLComponents(string: "\(BASE_URL)\(forecasts)\(API_VERSION)\(hourly)\(cityKey)")!
        urlComponents.queryItems = [
            apiKeyQueryItem,
            metricQueryItem
        ]

        return RxAlamofire.json(.get, urlComponents).mapArray(type: HourForecast.self)
    }

    static func getDailyForecast(cityKey: String) -> Observable<DayForecast> {
        var urlComponents = URLComponents(string: "\(BASE_URL)\(forecasts)\(API_VERSION)\(daily)\(cityKey)")!
        urlComponents.queryItems = [
            apiKeyQueryItem,
            metricQueryItem
        ]

        return RxAlamofire.json(.get, urlComponents).mapObject(type: DayForecast.self)
    }

}
