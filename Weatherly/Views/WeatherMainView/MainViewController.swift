//
//  ViewController.swift
//  Weatherly
//
//  Created by ITT on 04/06/2022.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    var backgroundImageView = UIImageView(image: UIImage(named: "gradient"))

    var topLabel: UILabel = {
        let topLabel = UILabel(font: .systemFont(ofSize: UIConstants.mediumFontSize, weight: .bold))
        topLabel.text = "Weatherly"

        return topLabel
    }()

    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.round()
        searchBar.backgroundColor = .clear

        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .clear
        } else {
            // Fallback on earlier versions
        }

        searchBar.placeholder = "Search city..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        return searchBar
    }()

    var searchResultsTableView: ContentSizedUITableView = {
        let searchResultsTableView = ContentSizedUITableView()

        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultsTableViewCellIdentifier")
        searchResultsTableView.round()
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false

        return searchResultsTableView
    }()

    private var mainViewModel = MainViewModel()

    private let disposeBag = DisposeBag()


    override func loadView() {
        super.loadView()

        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewModel.locationsArray.asObservable()
                .bind(to: searchResultsTableView.rx.items(cellIdentifier: "SearchResultsTableViewCellIdentifier"))
                { (_, model: Location, cell: UITableViewCell) in
                    cell.textLabel?.text = "\(model.localizedName ?? ""), \(model.countryName ?? "")"
                    cell.addBackgroundBlur()
                }
                .disposed(by: disposeBag)

        searchResultsTableView.rx.itemSelected
                .subscribe { [self] indexPath in
                    guard let row = indexPath.element?.row else { return }

                    mainViewModel.saveLocation(row: row)

                    let storyboard = UIStoryboard(name: "WeatherDetails", bundle: nil)
                    let weatherDetailsViewController = storyboard.instantiateViewController(withIdentifier: "weatherDetailsVcId") as! WeatherDetailsViewController
                    weatherDetailsViewController.weatherDetailsViewModel =
                            WeatherDetailsViewModel(mainViewModel.locationsArray.value[row].key!, mainViewModel.locationsArray.value[row].localizedName!)
                    present(weatherDetailsViewController, animated: true)
                }
                .disposed(by: disposeBag)


        //HACKY WAY OF HANDLING X IN A CIRCLE BUTTON CLICK AND ALSO CLEARING TABLEVIEW AFTER DELETING WHOLE TEXT
        searchBar.rx.text.bind(onNext: { [self] in
                    if $0 == "" { mainViewModel.getSearchHistory() }
                }).disposed(by: disposeBag)

    }

    private func setupUI() {
        backgroundImageView.frame = view.frame
        searchResultsTableView.backgroundColor = .clear

        view.addSubview(backgroundImageView)
        view.addSubview(topLabel)
        view.addSubview(searchResultsTableView)
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            topLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            topLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            topLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: UIConstants.mediumHeight)
        ])

        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            searchBar.topAnchor.constraint(equalTo: topLabel.layoutMarginsGuide.bottomAnchor, constant: UIConstants.marginMedium),
            searchBar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: UIConstants.mediumHeight)
        ])

        NSLayoutConstraint.activate([
            searchResultsTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            searchResultsTableView.topAnchor.constraint(equalTo: searchBar.layoutMarginsGuide.bottomAnchor, constant: UIConstants.marginMedium),
            searchResultsTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
        ])

        searchBar.rx.text.debounce(.milliseconds(UIConstants.debounceTime), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [self] in
                    if let city = $0 { mainViewModel.getListOfCities(city: city) }
                })
                .disposed(by: disposeBag)

    }

}


extension MainViewController {
    enum Constants {
        static let size = 0
    }
}

