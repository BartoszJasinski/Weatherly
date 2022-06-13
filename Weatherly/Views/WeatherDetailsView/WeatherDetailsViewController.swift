//
//  WeatherDetailsViewController.swift
//  Weatherly
//
//  Created by ITT on 07/06/2022.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class WeatherDetailsViewController: UIViewController {

    var backgroundImageView = UIImageView(image: UIImage(named: "gradient"))

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

        hourlyForecastCollectionView.showsHorizontalScrollIndicator = false
        hourlyForecastCollectionView.addBackgroundBlur()
        hourlyForecastCollectionView.round()
        hourlyForecastCollectionView.translatesAutoresizingMaskIntoConstraints = false

        return hourlyForecastCollectionView
    }()

    var dailyForecastTableView: ContentSizedUITableView = {
        let dailyForecastTableView = ContentSizedUITableView()

        dailyForecastTableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: "DailyForecastTableViewCellIdentifier")

        dailyForecastTableView.separatorStyle = .none
        dailyForecastTableView.addBackgroundBlur()
        dailyForecastTableView.round()

        dailyForecastTableView.translatesAutoresizingMaskIntoConstraints = false

        return dailyForecastTableView
    }()

    var weatherDetailsViewModel: WeatherDetailsViewModel!

    var disposeBag: DisposeBag = DisposeBag()


    override func loadView() {
        super.loadView()

        backgroundImageView.frame = view.frame
        backgroundImageView.contentMode = .scaleAspectFill

        cityLabel.text = weatherDetailsViewModel.cityName

        dailyForecastTableView.backgroundColor = .clear
        dailyForecastTableView.separatorColor = .clear

        view.addSubview(backgroundImageView)
        view.addSubview(cityLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(weatherDescriptionLabel)
        view.addSubview(hourlyForecastCollectionView)
        view.addSubview(dailyForecastTableView)

        NSLayoutConstraint.activate([
            cityLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: UIConstants.marginBig),
            cityLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: UIConstants.mediumHeight)
        ])


        NSLayoutConstraint.activate([
            temperatureLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: UIConstants.marginMedium),
            temperatureLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: UIConstants.mediumHeight)
        ])

        NSLayoutConstraint.activate([
            weatherDescriptionLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            weatherDescriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.safeAreaLayoutGuide.bottomAnchor),
            weatherDescriptionLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            weatherDescriptionLabel.heightAnchor.constraint(equalToConstant: UIConstants.mediumHeight)
        ])

        NSLayoutConstraint.activate([
            hourlyForecastCollectionView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            hourlyForecastCollectionView.topAnchor.constraint(equalTo: weatherDescriptionLabel.layoutMarginsGuide.topAnchor, constant: 100),
            hourlyForecastCollectionView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            hourlyForecastCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            dailyForecastTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            dailyForecastTableView.topAnchor.constraint(equalTo: hourlyForecastCollectionView.layoutMarginsGuide.bottomAnchor, constant: UIConstants.marginMedium),
            dailyForecastTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
        ])

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        weatherDetailsViewModel.currentConditions.asObservable().bind { [self] conditions in
                backgroundImageView.image = SharedEnums
                    .PrecipitationMode(iconPhrase: conditions.weatherText, precipitationType: conditions.precipitationType).backgroundImage

                    temperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: conditions.temperature?.metric?.value ?? 0).color
                    temperatureLabel.text = conditions.temperature?.metric?.valueFormatted

                    weatherDescriptionLabel.text = conditions.weatherText ?? ""
        }.disposed(by: disposeBag)


        weatherDetailsViewModel.hourForecastArray.asObservable().bind(to: hourlyForecastCollectionView.rx.items(cellIdentifier: "HourForecastCollectionViewCellIdentifier"))
                { (_, model: HourForecast, cell: HourForecastCollectionViewCell) in
                    cell.viewModel = HourForecastCollectionViewModel(hourForecast: model)
                }
                .disposed(by: disposeBag)

        weatherDetailsViewModel.dailyForecastArray.asObservable().bind(to: dailyForecastTableView.rx.items(cellIdentifier: "DailyForecastTableViewCellIdentifier"))
                { (_, model: WeatherConditions, cell: DailyForecastTableViewCell) in
                    cell.viewModel = DailyForecastTableViewModel(weatherConditions: model)
                }
                .disposed(by: disposeBag)

    }

}
