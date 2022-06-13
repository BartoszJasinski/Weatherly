//
// Created by ITT on 13/06/2022.
//

import RxSwift
import RxRelay

class WeatherDetailsViewModel {
    var cityKey: String!
    var cityName: String!

    let currentConditions: BehaviorRelay<CurrentConditions> = BehaviorRelay(value: CurrentConditions())
    let hourForecastArray: BehaviorRelay<[HourForecast]> = BehaviorRelay(value: [])
    let dailyForecastArray: BehaviorRelay<[WeatherConditions]> = BehaviorRelay(value: [])

    private let disposeBag = DisposeBag()

    init(_ cityKey: String, _ cityName: String) {
        self.cityKey = cityKey
        self.cityName = cityName

        getCurrentWeather(cityKey: cityKey)
        getHourlyForecast(cityKey: cityKey)
        getDailyForecast(cityKey: cityKey)
    }

    func getCurrentWeather(cityKey: String) {
        NetworkService.getCurrentWeather(cityId: cityKey).subscribe(onNext: { [self] currentConditions in
                    guard let currentConditions = currentConditions.first else { return }
                    self.currentConditions.accept(currentConditions)
                })
                .disposed(by: disposeBag)
    }

    func getHourlyForecast(cityKey: String)
    {
        NetworkService.getHourlyForecast(cityKey: cityKey).subscribe(onNext: { [self] hourForecasts in
                    hourForecastArray.accept(hourForecasts)
                })
                .disposed(by: disposeBag)
    }

    func getDailyForecast(cityKey: String)
    {
        NetworkService.getDailyForecast(cityKey: cityKey).subscribe(onNext: { [self] weatherData in
                    guard let dailyForecasts = weatherData.dailyForecasts else { return }
                    dailyForecastArray.accept(dailyForecasts)
                })
                .disposed(by: disposeBag)
    }
}