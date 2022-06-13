//
// Created by ITT on 10/06/2022.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    let dateLabel = UILabel().setupLook()

    let weatherImageView: UIImageView = {
        let weatherImageView = UIImageView()

        weatherImageView.contentMode = .left
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false

        return weatherImageView
    }()

    let highestTemperatureLabel = UILabel().setupLook()
    let lowestTemperatureLabel = UILabel(textColor: .lightGray)

    var viewModel: DailyForecastTableViewModel? {
        didSet { fillWithData() }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviews()
    }

    // MARK: UI Setup
    private func setupSubviews() {
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: UIConstants.smallHeight).isActive = true
        contentView.backgroundColor = .clear

        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(lowestTemperatureLabel)
        contentView.addSubview(highestTemperatureLabel)

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherImageView.rightAnchor.constraint(equalTo: highestTemperatureLabel.safeAreaLayoutGuide.leftAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherImageView.leftAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.rightAnchor, constant: UIConstants.marginMedium)
        ])

        NSLayoutConstraint.activate([
            highestTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            highestTemperatureLabel.rightAnchor.constraint(equalTo: lowestTemperatureLabel.leftAnchor),
            highestTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            highestTemperatureLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
        ])

        NSLayoutConstraint.activate([
            lowestTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            lowestTemperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            lowestTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lowestTemperatureLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            lowestTemperatureLabel.leftAnchor.constraint(equalTo: lowestTemperatureLabel.rightAnchor)
        ])

    }

    private func fillWithData() {
        dateLabel.text = viewModel?.dateText

        if #available(iOS 13.0, *) {
            weatherImageView.image = viewModel?.weatherImage
        }

        lowestTemperatureLabel.text = viewModel?.lowestTemperatureText
        lowestTemperatureLabel.textColor = viewModel?.lowestTemperatureColor

        highestTemperatureLabel.text = viewModel?.highestTemperatureText
        highestTemperatureLabel.textColor = viewModel?.highestTemperatureColor
        backgroundColor = .clear
    }

}


class DailyForecastTableViewModel {
    let dateText: String
    let weatherImage: UIImage?
    let lowestTemperatureText: String
    let lowestTemperatureColor: UIColor
    let highestTemperatureText: String
    let highestTemperatureColor: UIColor

    init(weatherConditions: WeatherConditions) {
        dateText = Date.getWeekDay(dateText: weatherConditions.date ?? "")

        if #available(iOS 13.0, *) {
            weatherImage = SharedEnums.PrecipitationMode.init(iconPhrase: weatherConditions.iconPhrase, precipitationType: weatherConditions.precipitationType).icon
        } else {
            weatherImage = nil
        }

        lowestTemperatureText = weatherConditions.temperature?.minimum?.valueFormatted ?? ""
        lowestTemperatureColor = SharedEnums.TemperatureMode(temperature: weatherConditions.temperature?.minimum?.value ?? 0.0).color
        highestTemperatureText = weatherConditions.temperature?.maximum?.valueFormatted ?? ""
        highestTemperatureColor = SharedEnums.TemperatureMode(temperature: weatherConditions.temperature?.maximum?.value ?? 0.0).color
    }
}