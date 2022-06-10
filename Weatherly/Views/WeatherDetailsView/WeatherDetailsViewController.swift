//
//  WeatherDetailsViewController.swift
//  Weatherly
//
//  Created by ITT on 07/06/2022.
//

import UIKit
import RxSwift
import RxRelay

class WeatherDetailsViewController: UIViewController {
    var backgroundImageView: UIImageView = {
        let  backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "rainyImage")

        return backgroundImageView
    }()

    var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = .systemFont(ofSize: 40)
        cityLabel.textAlignment = .center
        cityLabel.textColor = .white
        cityLabel.translatesAutoresizingMaskIntoConstraints = false

        return cityLabel
    }()

    var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = .systemFont(ofSize: 70, weight: .light)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        return temperatureLabel
    }()

    var weatherDescriptionLabel: UILabel = {
        let weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = .systemFont(ofSize: 20)
        weatherDescriptionLabel.textColor = .white
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        return weatherDescriptionLabel
    }()

    var hourlyForecastCollectionView: UICollectionView = {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionViewLayout.itemSize = CGSize(width: 60, height: 60)
        collectionViewLayout.scrollDirection = .horizontal

        let hourlyForecastCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)

        hourlyForecastCollectionView.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")

        hourlyForecastCollectionView.backgroundColor = .white.withAlphaComponent(0.2)
        hourlyForecastCollectionView.showsHorizontalScrollIndicator = false
        hourlyForecastCollectionView.translatesAutoresizingMaskIntoConstraints = false

        return hourlyForecastCollectionView
    }()

    var dailyForecastTableView: UITableView = {
        let dailyForecastTableView = UITableView()
        dailyForecastTableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: "MyCell")
        dailyForecastTableView.round()
        dailyForecastTableView.translatesAutoresizingMaskIntoConstraints = false

        return dailyForecastTableView
    }()


    var disposeBag: DisposeBag = DisposeBag()

    var cityKey: String!
    var cityName: String!

    private let hourForecastArray: BehaviorRelay<[HourForecast]> = BehaviorRelay(value: [])
    private let dailyForecastArray: BehaviorRelay<[WeatherConditions]> = BehaviorRelay(value: [])


    override func loadView() {
        super.loadView()

        backgroundImageView.frame = view.frame
        view.addSubview(backgroundImageView)

        cityLabel.text = cityName
        view.addSubview(cityLabel)

        NSLayoutConstraint.activate([
            cityLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
            cityLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: 60)
        ])


        view.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            temperatureLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 60)
        ])


        view.addSubview(weatherDescriptionLabel)
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            weatherDescriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            weatherDescriptionLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            weatherDescriptionLabel.heightAnchor.constraint(equalToConstant: 60)
        ])


        hourlyForecastCollectionView.round()


        view.addSubview(hourlyForecastCollectionView)
        NSLayoutConstraint.activate([
            hourlyForecastCollectionView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            hourlyForecastCollectionView.topAnchor.constraint(equalTo: weatherDescriptionLabel.layoutMarginsGuide.topAnchor, constant: 100),
            hourlyForecastCollectionView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            hourlyForecastCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])


        view.addSubview(dailyForecastTableView)
        NSLayoutConstraint.activate([
            dailyForecastTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            dailyForecastTableView.topAnchor.constraint(equalTo: hourlyForecastCollectionView.layoutMarginsGuide.bottomAnchor, constant: 20),
            dailyForecastTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            dailyForecastTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        dailyForecastTableView.backgroundColor = .white.withAlphaComponent(0.2)

    }

    override func viewDidLoad() {
        super.viewDidLoad()


        hourForecastArray.asObservable().bind(to: hourlyForecastCollectionView.rx.items(cellIdentifier: "MyCell")) { (_, model: HourForecast, cell: HourForecastCollectionViewCell) in
                    cell.temperatureLabel.text = "\(model.temperature?.value ?? 0.0)"
                    cell.temperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: model.temperature?.value ?? 0.0).color
                    cell.hourLabel.text = DateUtils.getComponentOutOfDate(dateText: model.dateTime ?? "", component: .hour) + ":00"
                }
                .disposed(by: disposeBag)

        dailyForecastArray.asObservable().bind(to: dailyForecastTableView.rx.items(cellIdentifier: "MyCell")) { (_, model: WeatherConditions, cell: DailyForecastTableViewCell) in
                    cell.dateLabel.text = "\(DateUtils.getComponentOutOfDate(dateText: model.date ?? "", component: .day)).\(DateUtils.getComponentOutOfDate(dateText: model.date ?? "", component: .month))"
                    cell.lowestTemperatureLabel.text = "\(model.temperature?.minimum?.value ?? 0.0)"
                    cell.highestTemperatureLabel.text = "\(model.temperature?.maximum?.value ?? 0.0)"
                }
                .disposed(by: disposeBag)


        getCurrentWeather(cityKey: cityKey)
        getHourlyForecast(cityKey: cityKey)
        getDailyForecast(cityKey: cityKey)

    }

    func getCurrentWeather(cityKey: String) {
        NetworkRepository.getCurrentWeather(cityId: cityKey).subscribe(onNext: { [self] currentConditions in
                    print("getCurrentWeather = \(currentConditions.first?.temperature?.metric?.value ?? 0)")
                    temperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: currentConditions.first?.temperature?.metric?.value ?? 0).color
                    temperatureLabel.text = TemperatureUtils.formatTemperature(temperature: "\(currentConditions.first?.temperature?.metric?.value ?? 0)")
                    weatherDescriptionLabel.text = currentConditions.first?.weatherText ?? "ABC"
                })
                .disposed(by: disposeBag)
    }

    func getHourlyForecast(cityKey: String)
    {
        NetworkRepository.getHourlyForecast(cityKey: cityKey).subscribe(onNext: { [self] hourForecasts in
                    print("getHourlyForecast = \(hourForecasts.first?.temperature?.value ?? 0)")
                    hourForecastArray.accept(hourForecasts)
                    hourlyForecastCollectionView.reloadData()
                })
                .disposed(by: disposeBag)
    }

    func getDailyForecast(cityKey: String)
    {
        NetworkRepository.getDailyForecast(cityKey: cityKey).subscribe(onNext: { [self] weatherData in
                    print("getFutureWeather = \(weatherData.dailyForecasts?[0].temperature?.minimum?.value ?? 0)")
                    guard let dailyForecasts = weatherData.dailyForecasts else { return }
                    dailyForecastArray.accept(dailyForecasts)
                })
                .disposed(by: disposeBag)
    }


}
