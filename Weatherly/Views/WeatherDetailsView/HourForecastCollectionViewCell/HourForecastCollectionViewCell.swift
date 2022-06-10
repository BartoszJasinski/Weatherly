//
// Created by ITT on 10/06/2022.
//

import UIKit

class HourForecastCollectionViewCell: UICollectionViewCell
{
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
            imageView.image = UIImage(systemName: "cloud.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
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