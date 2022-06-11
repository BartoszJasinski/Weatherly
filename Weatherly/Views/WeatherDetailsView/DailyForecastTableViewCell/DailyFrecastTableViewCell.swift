//
// Created by ITT on 10/06/2022.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {
    //TODO: create fucntions which setups UILABES etc. because you use many occurances of the same commands
    let dateLabel = UILabel().setupLook()

    let weatherImageView: UIImageView = {
        let imageView = UIImageView()

        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "cloud.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        } else {
            // Fallback on earlier versions
        }

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let highestTemperatureLabel = UILabel().setupLook()
    let lowestTemperatureLabel = UILabel().setupLook()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupSubviews()
    }


    func setupSubviews(){
        contentView.backgroundColor = .brown

        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(lowestTemperatureLabel)
        contentView.addSubview(highestTemperatureLabel)

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherImageView.rightAnchor.constraint(equalTo: highestTemperatureLabel.safeAreaLayoutGuide.rightAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherImageView.leftAnchor.constraint(equalTo: dateLabel.safeAreaLayoutGuide.leftAnchor)
        ])


        NSLayoutConstraint.activate([
            highestTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            highestTemperatureLabel.rightAnchor.constraint(equalTo: lowestTemperatureLabel.leftAnchor),
            highestTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            highestTemperatureLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
        ])


        NSLayoutConstraint.activate([
            lowestTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            lowestTemperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            lowestTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lowestTemperatureLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            lowestTemperatureLabel.leftAnchor.constraint(equalTo: lowestTemperatureLabel.rightAnchor)
        ])


    }


}