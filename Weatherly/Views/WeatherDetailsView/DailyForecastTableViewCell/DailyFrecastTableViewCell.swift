//
// Created by ITT on 10/06/2022.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell
{
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = UIColor.darkGray
        dateLabel.text = "00.00"
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        return dateLabel
    }()

    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        //TODO: PROVIDE IMAGES FOR IOS < 13
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "cloud.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        } else {
            // Fallback on earlier versions
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    let lowestTemperatureLabel: UILabel = {
        let lowestTemperatureLabel = UILabel()
        lowestTemperatureLabel.textColor = UIColor.darkGray
        lowestTemperatureLabel.font = UIFont.systemFont(ofSize: 14)
        lowestTemperatureLabel.text = "01"
        lowestTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        return lowestTemperatureLabel
    }()

    let highestTemperatureLabel: UILabel = {
        let highestTemperatureLabel = UILabel()
        highestTemperatureLabel.textColor = UIColor.lightGray
        highestTemperatureLabel.font = UIFont.systemFont(ofSize: 14)
        highestTemperatureLabel.text = "99"
        highestTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false

        return highestTemperatureLabel
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


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()

    }


    func addViews(){
        contentView.backgroundColor = .white.withAlphaComponent(.zero)

        contentView.addSubview(dateLabel)
        contentView.addSubview(lowestTemperatureLabel)
        contentView.addSubview(highestTemperatureLabel)

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])

//        contentView.addSubview(weatherImageView)
//        NSLayoutConstraint.activate([
//            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            weatherImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            weatherImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
//        ])



        NSLayoutConstraint.activate([
            lowestTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            lowestTemperatureLabel.rightAnchor.constraint(equalTo: highestTemperatureLabel.leftAnchor),
            lowestTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lowestTemperatureLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
        ])


        NSLayoutConstraint.activate([
            highestTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            highestTemperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            highestTemperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            highestTemperatureLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            highestTemperatureLabel.leftAnchor.constraint(equalTo: lowestTemperatureLabel.rightAnchor)
        ])


    }


}