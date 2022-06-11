//
//  ViewController.swift
//  Weatherly
//
//  Created by ITT on 04/06/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
        
    var backgroundImageView: UIImageView = {
        let  backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "gradient")

        return backgroundImageView
    }()

    var topLabel: UILabel = {
        let topLabel = UILabel(font: .systemFont(ofSize: UIConstants.mediumFontSize, weight: .bold))
        topLabel.text = "Weatherly"

        return topLabel
    }()

    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.round()
        searchBar.backgroundColor = .white.withAlphaComponent(UIConstants.transparentView)

        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white.withAlphaComponent(UIConstants.transparentView)
        } else {
            // Fallback on earlier versions
        }

        searchBar.placeholder = "Search city..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        return searchBar
    }()

    var searchResultsTableView: UITableView = {
        let searchResultsTableView = UITableView()
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchResultsTableViewCellIdentifier")
        searchResultsTableView.round()
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false

        return searchResultsTableView
    }()

    private var locationsTableView: UITableView!

    var disposeBag: DisposeBag = DisposeBag()

    private let locationsArray: BehaviorRelay<[Location]> = BehaviorRelay(value: [])

    override func loadView() {
        super.loadView()

        backgroundImageView.frame = view.frame
        view.addSubview(backgroundImageView)

        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationsArray.asObservable()
                .bind(to: searchResultsTableView.rx.items(cellIdentifier: "SearchResultsTableViewCellIdentifier")) { (_, model: Location, cell: UITableViewCell) in
                    cell.textLabel?.text = "\(model.localizedName ?? ""), \(model.countryName ?? "")"
                }
                .disposed(by: disposeBag)

        searchResultsTableView.rx.itemSelected
                .subscribe { [self] indexPath in
                    guard let row = indexPath.element?.row else { return }

                    let storyboard = UIStoryboard(name: "WeatherDetails", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "weatherDetailsVcId") as! WeatherDetailsViewController
                    vc.cityKey = locationsArray.value[row].key
                    vc.cityName = locationsArray.value[row].localizedName
                    present(vc, animated: true)
                }
                .disposed(by: disposeBag)


        //HACKY WAY OF HANDLING X IN A CIRCLE BUTTON CLICK AND ALSO CLEARING TABLEVIEW AFTER DELETING WHOLE TEXT
        searchBar.rx.text.bind(onNext: { [self] in
                    if $0 == "" { locationsArray.accept([]) }
                }).disposed(by: disposeBag)

    }



    private func setupUI() {

        view.addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            topLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            topLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            searchBar.topAnchor.constraint(equalTo: topLabel.layoutMarginsGuide.bottomAnchor, constant: UIConstants.marginMedium),
            searchBar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])

        searchBar.rx.text.debounce(.milliseconds(UIConstants.debounceTime), scheduler: MainScheduler.instance)
                .subscribe(onNext: { [self] in
                    if let city = $0 { getListOfCities(city: city) }
                })
                .disposed(by: disposeBag)


        view.addSubview(searchResultsTableView)
        NSLayoutConstraint.activate([
            searchResultsTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            searchResultsTableView.topAnchor.constraint(equalTo: searchBar.layoutMarginsGuide.bottomAnchor, constant: UIConstants.marginMedium),
            searchResultsTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
//            searchResultsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        searchResultsTableView.backgroundColor = .white.withAlphaComponent(UIConstants.transparentView)

    }


}


extension MainViewController {
    func getListOfCities(city: String)
    {
        NetworkRepository.getCitiesMatchingName(city: city).subscribe(onNext: { [self] locations in
                    locationsArray.accept(locations)
                }).disposed(by: disposeBag)
    }



}


extension MainViewController {
    enum Constants {
        static let size = 0
    }
}

