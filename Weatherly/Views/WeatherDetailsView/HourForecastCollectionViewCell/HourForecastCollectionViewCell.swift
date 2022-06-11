//
// Created by ITT on 10/06/2022.
//

import UIKit

//TODO ROUND ALL TEMPERATURES TO WHOLE NUMBERS
class HourForecastCollectionViewCell: UICollectionViewCell
{
    let hourLabel = UILabel().setupLook()

    let weatherImageView: UIImageView = {
        let imageView = UIImageView()

        if #available(iOS 13.0, *) {
            //TODO: CREATE COLORING FUNCTION
            imageView.image = UIImage(systemName: "sun.max.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        } else {
            // Fallback on earlier versions
        }

        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let temperatureLabel = UILabel().setupLook()


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupSubviews()
    }

    func setupSubviews(){
        contentView.backgroundColor = .brown

        contentView.addSubview(hourLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureLabel)

        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            hourLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            hourLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
            hourLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: hourLabel.safeAreaLayoutGuide.bottomAnchor),
            weatherImageView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: temperatureLabel.safeAreaLayoutGuide.topAnchor),
            weatherImageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            temperatureLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.25),
            temperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            temperatureLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
    }

}