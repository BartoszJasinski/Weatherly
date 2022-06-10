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

    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.round()
        searchBar.backgroundColor = .white.withAlphaComponent(0.0)

        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white.withAlphaComponent(0.0)
        } else {
            // Fallback on earlier versions
        }

        searchBar.placeholder = "Search city..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        return searchBar
    }()

    var searchResultsTableView: UITableView = {
        let searchResultsTableView = UITableView()
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
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

        locationsArray.asObservable().bind(to: searchResultsTableView.rx.items(cellIdentifier: "MyCell")) { (_, model: Location, cell: UITableViewCell) in
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

    }



    private func setupUI() {

        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])

        searchBar.rx.text.debounce(.milliseconds(UIConstants.debounceTime), scheduler: MainScheduler.instance)
                .subscribe(onNext:
                { [self] in
                    if let city = $0 { getListOfCities(city: city) }
                })
                .disposed(by: disposeBag)


//        searchResultsTableView.dataSource = self
//        searchResultsTableView.delegate = self

        view.addSubview(searchResultsTableView)
        NSLayoutConstraint.activate([
            searchResultsTableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            searchResultsTableView.topAnchor.constraint(equalTo: searchBar.layoutMarginsGuide.bottomAnchor, constant: 20),
            searchResultsTableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        searchResultsTableView.backgroundColor = .white.withAlphaComponent(0.0)

    }


}




// MARK: Extension for creating UI
//extension MainViewController: UITableViewDelegate, UITableViewDataSource  {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(locationsArray[indexPath.row].key)")
//        let storyboard = UIStoryboard(name: "WeatherDetails", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "weatherDetailsVcId") as! WeatherDetailsViewController
//        vc.cityKey = locationsArray[indexPath.row].key
//        vc.cityName = locationsArray[indexPath.row].localizedName
//        present(vc, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        locationsArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
//        cell.textLabel!.text = "\(locationsArray[indexPath.row].localizedName ?? ""), \(locationsArray[indexPath.row].countryName ?? "")"
//        return cell
//    }
//
//
//
//}


extension MainViewController {
    func getListOfCities(city: String)
    {
        NetworkRepository.getCitiesMatchingName(city: city).subscribe(onNext: { [self] locations in
                    locationsArray.accept(locations)
                    locations.forEach
                    {
                        // THIS IS ONLY DEBUG PRINT
                        print("getListOfCities = " + ($0.localizedName ?? "") + ", " + ($0.countryName ?? "NO COUNTRY"))
//                        locationsArray.accept(locationsArray.value.append(locations)
                    }
                    searchResultsTableView.reloadData()

                }).disposed(by: disposeBag)
    }



}

