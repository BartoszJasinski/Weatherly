//
//  WeatherDetailsViewController.swift
//  Weatherly
//
//  Created by ITT on 07/06/2022.
//

import UIKit
import RxSwift

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

        return temperatureLabel
    }()

    var weatherDescriptionLabel: UILabel = {
        let weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = .systemFont(ofSize: 20)
        weatherDescriptionLabel.textColor = .white

        return weatherDescriptionLabel
    }()

    var hourlyForecastCollectionView: UICollectionView = {
        let collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionViewLayout.itemSize = CGSize(width: 60, height: 60)
        collectionViewLayout.scrollDirection = .horizontal

        let hourlyForecastCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: collectionViewLayout)

        hourlyForecastCollectionView.register(HourForecastCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")

        hourlyForecastCollectionView.backgroundColor = .white.withAlphaComponent(0.35)
        hourlyForecastCollectionView.showsHorizontalScrollIndicator = false

        return hourlyForecastCollectionView
    }()

    var disposeBag: DisposeBag = DisposeBag()

    var cityKey: String!
    var cityName: String!

    private var hourForecastArray: [HourForecast] = []

    override func loadView() {
        super.loadView()
        print("123")

        backgroundImageView.frame = view.frame
        view.addSubview(backgroundImageView)

        cityLabel.text = cityName




//        if #available(iOS 13.0, *) {
//            cityLabel.image = UIImage(systemName: "cloud.fill")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
//        } else {
//            print("IMAGE NOT AVAILABLE")
//        }
        view.addSubview(cityLabel)

        NSLayoutConstraint.activate([
            cityLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            cityLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            cityLabel.heightAnchor.constraint(equalToConstant: 100)
        ])



        temperatureLabel.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 100)
        view.addSubview(temperatureLabel)

        weatherDescriptionLabel.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 100)
        view.addSubview(weatherDescriptionLabel)

//        NSLayoutConstraint.activate([
//            hourlyForecastCollectionView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
//            hourlyForecastCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 400),
//            hourlyForecastCollectionView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
//            hourlyForecastCollectionView.heightAnchor.constraint(equalToConstant: 100)
//        ])

        hourlyForecastCollectionView.frame = CGRect(x: 0, y: 400, width: view.frame.width, height: 100)
        hourlyForecastCollectionView.round()

        hourlyForecastCollectionView.dataSource = self
        hourlyForecastCollectionView.delegate = self

        view.addSubview(hourlyForecastCollectionView)

        print("098")

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getCurrentWeather(cityKey: cityKey)
        getHourlyForecast(cityKey: cityKey)
//        getFutureForecast(cityKey: cityKey)

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
        NetworkRepository.getHourlyForecast(cityKey: cityKey).subscribe(onNext: { [self] hourForecast in
                    print("getHourlyForecast = \(hourForecast.first?.temperature?.value ?? 0)")
                    temperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: hourForecast.first?.temperature?.value).color
                    temperatureLabel.text = TemperatureUtils.formatTemperature(temperature: "\(hourForecast.first?.temperature?.value ?? 0)")

                    hourForecastArray.removeAll()
                    hourForecast.forEach
                    {
                        hourForecastArray.append($0)
                    }
                    hourlyForecastCollectionView.reloadData()
                })
                .disposed(by: disposeBag)
    }

    func getFutureForecast(cityKey: String)
    {
        NetworkRepository.getFutureForecast(cityKey: cityKey).subscribe(onNext: { [self] weatherData in
                    print("getFutureWeather = \(weatherData.dailyForecasts?[0].temperature?.minimum?.value ?? 0)")
                    temperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: weatherData.dailyForecasts?[0].temperature?.minimum?.value).color
                    temperatureLabel.text = TemperatureUtils.formatTemperature(temperature: "\(weatherData.dailyForecasts?[0].temperature?.minimum?.value ?? 0)")
                })
                .disposed(by: disposeBag)
    }


}


extension WeatherDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hourForecastArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! HourForecastCollectionViewCell

        myCell.temperatureLabel.text = "\(hourForecastArray[indexPath.row].temperature?.value ?? 0.0)"
        myCell.temperatureLabel.textColor = SharedEnums.TemperatureMode(temperature: hourForecastArray[indexPath.row].temperature?.value ?? 0.0).color
        myCell.hourLabel.text = DateUtils.getComponentOutOfDate(dateText: hourForecastArray[indexPath.row].dateTime ?? "", component: .hour)

        return myCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 60, height: 60)
    }
}

extension WeatherDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}



/////////////
///
///
///
///

class HourForecastCollectionViewCell: UICollectionViewCell {

    let hourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.text = "11:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        //TODO: PROVIDE IMAGES FOR IOS < 13
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(named: "sun.max.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        } else {
            // Fallback on earlier versions
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.yellow
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "99"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()


//    let topSeparatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.darkGrayColor()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    let bottomSeparatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.darkGrayColor()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//
//    let likeButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Like", forState: .Normal)
//        button.titleLabel?.font = UIFont.systemFontOfSize(18)
//        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    let hireButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Hire", forState: .Normal)
//        button.titleLabel?.font = UIFont.systemFontOfSize(18)
//        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//
//    let messageButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Message", forState: .Normal)
//        button.titleLabel?.font = UIFont.systemFontOfSize(18)
//        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//
//
//    let stackView: UIStackView = {
//        let sv = UIStackView()
//        sv.axis  = UILayoutConstraintAxis.Horizontal
//        sv.alignment = UIStackViewAlignment.Center
//        sv.distribution = UIStackViewDistribution.FillEqually
//        sv.translatesAutoresizingMaskIntoConstraints = false;
//        return sv
//    }()




    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
    }




    func addViews(){

//        addSubview(profileImageButton)
//        contentView.addSubview(hourLabel)
//        addSubview(distanceLabel)
//        addSubview(pricePerHourLabel)
//        addSubview(ratingLabel)
        contentView.addSubview(hourLabel)
        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            hourLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hourLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            hourLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])

//        contentView.addSubview(weatherImageView)
//        NSLayoutConstraint.activate([
//            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            weatherImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            weatherImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
//        ])

        contentView.addSubview(temperatureLabel)
        NSLayoutConstraint.activate([
            temperatureLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            temperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            temperatureLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])


//        addSubview(topSeparatorView)
//        addSubview(bottomSeparatorView)

        // Stack View
//        addSubview(likeButton)
//        addSubview(messageButton)
//        addSubview(hireButton)
//        addSubview(stackView)


//        profileImageButton.leftAnchor.constraintEqualToAnchor(leftAnchor, constant: 5).active = true
//        profileImageButton.topAnchor.constraintEqualToAnchor(topAnchor, constant: 10).active = true
//        profileImageButton.heightAnchor.constraintEqualToConstant(36).active = true
//        profileImageButton.widthAnchor.constraintEqualToConstant(36).active = true

//        NSLayoutConstraint.activate([
//            hourLabel.leftAnchor.constraint(equalTo: leftAnchor),
//            hourLabel.rightAnchor.constraint(equalTo: rightAnchor),
//            hourLabel.heightAnchor.constraint(equalToConstant: 30)
//        ])



      /*  NSLayoutConstraint.activate([
            hourLabel.leftAnchor.constraint(equalTo: leftAnchor),
            hourLabel.rightAnchor.constraint(equalTo: rightAnchor),
            hourLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        NSLayoutConstraint.activate([
            hourLabel.leftAnchor.constraint(equalTo: leftAnchor),
            hourLabel.rightAnchor.constraint(equalTo: rightAnchor),
            hourLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        weatherImageView.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 10)
        weatherImageView.widthAnchor.constraint(equalTo: widthAnchor)
        weatherImageView.heightAnchor.constraint(equalTo: UIScreen.mainScreen().bounds.width - 20)

        temperatureLabel.topAnchor.constraint(weatherImageView.bottomAnchor, constant: 10).active = true
        temperatureLabel.leftAnchor.constraint(profileImageButton.leftAnchor).active = true
*/
//        distanceLabel.leftAnchor.constraintEqualToAnchor(hourLabel.leftAnchor).active = true
//        distanceLabel.centerYAnchor.constraintEqualToAnchor(profileImageButton.centerYAnchor, constant: 8).active = true
//        distanceLabel.widthAnchor.constraintEqualToConstant(300)
//
//        pricePerHourLabel.rightAnchor.constraintEqualToAnchor(rightAnchor, constant: -10).active = true
//        pricePerHourLabel.centerYAnchor.constraintEqualToAnchor(hourLabel.centerYAnchor).active = true
//
//        // Distance depeneded on the priceLabel and distance Label
//        ratingLabel.rightAnchor.constraintEqualToAnchor(pricePerHourLabel.rightAnchor).active = true
//        ratingLabel.centerYAnchor.constraintEqualToAnchor(distanceLabel.centerYAnchor).active = true



//        topSeparatorView.topAnchor.constraintEqualToAnchor(temperatureLabel.bottomAnchor, constant: 10).active = true
//        topSeparatorView.widthAnchor.constraintEqualToAnchor(widthAnchor).active = true
//        topSeparatorView.heightAnchor.constraintEqualToConstant(0.5).active = true
//
//        stackView.addArrangedSubview(likeButton)
//        stackView.addArrangedSubview(hireButton)
//        stackView.addArrangedSubview(messageButton)
//
//        stackView.topAnchor.constraint(equalTo: topSeparatorView.bottomAnchor, constant: 4).active = true
//        stackView.widthAnchor.constraint(equalTo: widthAnchor).active = true
//        stackView.centerXAnchor.constraintEqualToAnchor(centerXAnchor).active = true
//
//        bottomSeparatorView.topAnchor.constraintEqualToAnchor(stackView.bottomAnchor, constant: 4).active = true
//        bottomSeparatorView.widthAnchor.constraintEqualToAnchor(widthAnchor).active = true
//        bottomSeparatorView.heightAnchor.constraintEqualToConstant(0.5).active = true


    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}