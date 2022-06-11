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

    var backgroundImageView = UIImageView(image: UIImage(named: "rainyImage"))

    var cityLabel = UILabel(font: .systemFont(ofSize: UIConstants.mediumFontSize))
    var temperatureLabel = UILabel(font: .systemFont(ofSize: UIConstants.bigFontSize, weight: .light))
    var weatherDescriptionLabel = UILabel(font: .systemFont(ofSize: UIConstants.smallFontSize))

    var hourlyForecastCollectionView: UICollectionView = {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionViewLayout.itemSize = CGSize(width: 80, height: 80)
        collectionViewLayout.scrollDirection = .horizontal

        let hourlyForecastCollectionView = UICollectionView(frame: CGRect(x: CGFloat.zero, y: .zero, width: .zero, height: .zero),
                collectionViewLayout: collectionViewLayout)

        hourlyForecastCollectionView.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: "HourForecastCollectionViewCellIdentifier")

        hourlyForecastCollectionView.backgroundColor = .clear/*.white.withAlphaComponent(UIConstants.viewOpacityLevel)*/
        hourlyForecastCollectionView.showsHorizontalScrollIndicator = false
        hourlyForecastCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyForecastCollectionView.round()

        return hourlyForecastCollectionView
    }()

    var dailyForecastTableView: ContentSizedTableView = {
        let dailyForecastTableView = ContentSizedTableView()
        dailyForecastTableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: "DailyForecastTableViewCellIdentifier")
        dailyForecastTableView.backgroundColor = .clear
        dailyForecastTableView.separatorStyle = .none
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
            cityLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: UIConstants.marginBig),
            cityLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: UIConstants.mediumHeight)
        ])


        view.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: UIConstants.marginMedium),
            temperatureLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: UIConstants.mediumHeight)
        ])

        view.addSubview(weatherDescriptionLabel)
        NSLayoutConstraint.activate([
            weatherDescriptionLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            weatherDescriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.safeAreaLayoutGuide.bottomAnchor),
            weatherDescriptionLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            weatherDescriptionLabel.heightAnchor.constraint(equalToConstant: UIConstants.mediumHeight)
        ])

        view.addSubview(hourlyForecastCollectionView)
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))

        visualEffectView.frame = hourlyForecastCollectionView.bounds
        visualEffectView.autoresizingMask = .flexibleWidth
//        hourlyForecastCollectionView.addSubview(visualEffectView)
        hourlyForecastCollectionView.backgroundView = visualEffectView
        NSLayoutConstraint.activate([
            hourlyForecastCollectionView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            hourlyForecastCollectionView.topAnchor.constraint(equalTo: weatherDescriptionLabel.layoutMarginsGuide.topAnchor, constant: 100),
            hourlyForecastCollectionView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            hourlyForecastCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])


        view.addSubview(dailyForecastTableView)
        let visualEffectView2 = UIVisualEffectView(effect: UIBlurEffect(style: .light))

        visualEffectView2.frame = hourlyForecastCollectionView.bounds
        visualEffectView2.autoresizingMask = .flexibleWidth
//        hourlyForecastCollectionView.addSubview(visualEffectView)
        dailyForecastTableView.backgroundView = visualEffectView2
        NSLayoutConstraint.activate([
            dailyForecastTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            dailyForecastTableView.topAnchor.constraint(equalTo: hourlyForecastCollectionView.layoutMarginsGuide.bottomAnchor, constant: UIConstants.marginMedium),
            dailyForecastTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
//            dailyForecastTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        dailyForecastTableView.backgroundColor = .clear
        dailyForecastTableView.separatorColor = .clear
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        hourForecastArray.asObservable().bind(to: hourlyForecastCollectionView.rx.items(cellIdentifier: "HourForecastCollectionViewCellIdentifier"))
                { (_, model: HourForecast, cell: HourForecastCollectionViewCell) in
                    cell.temperatureLabel.text = model.temperature?.valueFormatted
                    cell.temperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: model.temperature?.value ?? 0.0).color
                    cell.hourLabel.text = Date.getComponentOutOfDate(dateText: model.dateTime ?? "", component: .hour) + ":00"
                }
                .disposed(by: disposeBag)

        dailyForecastArray.asObservable().bind(to: dailyForecastTableView.rx.items(cellIdentifier: "DailyForecastTableViewCellIdentifier"))
                { (_, model: WeatherConditions, cell: DailyForecastTableViewCell) in
                    cell.dateLabel.text = Date.getWeekDay(dateText: model.date ?? "")
                    cell.lowestTemperatureLabel.text = model.temperature?.minimum?.valueFormatted
                    cell.lowestTemperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: model.temperature?.minimum?.value ?? 0.0).color

                    cell.highestTemperatureLabel.text = model.temperature?.maximum?.valueFormatted
                    cell.highestTemperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: model.temperature?.maximum?.value ?? 0.0).color
                    cell.backgroundColor = .clear//.white.withAlphaComponent(UIConstants.viewOpacityLevel)
                }
                .disposed(by: disposeBag)

        getCurrentWeather(cityKey: cityKey)
        getHourlyForecast(cityKey: cityKey)
        getDailyForecast(cityKey: cityKey)

    }

    func getCurrentWeather(cityKey: String) {
        NetworkRepository.getCurrentWeather(cityId: cityKey).subscribe(onNext: { [self] currentConditions in
                    temperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: currentConditions.first?.temperature?.metric?.value ?? 0).color
                    temperatureLabel.text = currentConditions.first?.temperature?.metric?.valueFormatted
                    weatherDescriptionLabel.text = currentConditions.first?.weatherText ?? ""
                })
                .disposed(by: disposeBag)
    }

    func getHourlyForecast(cityKey: String)
    {
        NetworkRepository.getHourlyForecast(cityKey: cityKey).subscribe(onNext: { [self] hourForecasts in
                    hourForecastArray.accept(hourForecasts)
                })
                .disposed(by: disposeBag)
    }

    func getDailyForecast(cityKey: String)
    {
        NetworkRepository.getDailyForecast(cityKey: cityKey).subscribe(onNext: { [self] weatherData in
                    guard let dailyForecasts = weatherData.dailyForecasts else { return }
                    dailyForecastArray.accept(dailyForecasts)
                })
                .disposed(by: disposeBag)
    }


}

import UIKit

final class ContentSizedTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}