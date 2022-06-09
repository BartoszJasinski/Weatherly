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
        
//    var avPlayer: AVPlayer!
//    var avPlayerLayer: AVPlayerLayer!
    var searchBar: UISearchBar!
    var searchResultsTableView: UITableView!
    private var locationsTableView: UITableView!

    var disposeBag: DisposeBag = DisposeBag()

    private var locationsArray: [Location] = []


    override func loadView() {
        super.loadView()
        print("ABC")

        let isoDate = "2022-06-09T19:00:00+02:00"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: isoDate)!
        let hour = Calendar.current.component(.hour, from: date)
        print("\(hour)")

        setupView()
        setupSearchBarLook()

        print("XYZ")

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let nr = NetworkRepository()
    }

//    private func playBackgroundVideo() {
//        if let filePath = Bundle.main.path(forResource: "01d", ofType: "mp4") {
//            let filePathUrl = NSURL.fileURL(withPath: filePath)
//            avPlayer = AVPlayer(url: filePathUrl)
//            let playerLayer = AVPlayerLayer(player: avPlayer)
//            playerLayer.frame = backgroundView.bounds
//            playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.avPlayer?.currentItem, queue: nil) { (_) in
//                self.avPlayer?.seek(to: CMTime.zero)
//                self.avPlayer?.play()
//            }
//
//            backgroundView.layer.addSublayer(playerLayer)
//            avPlayer?.play()
//        } else {
//            print("ERROR")
//        }
//    }

}




// MARK: Extension for creating UI
extension MainViewController: UITableViewDelegate, UITableViewDataSource  {
    private func setupView() {
//        view = UIView()
        view.backgroundColor = .systemGreen
    }

    private func setupSearchBarLook() {
        searchBar = UISearchBar()
//        searchBar.sizeToFit()
//        navigationItem.titleView = searchBar
//        searchBar.round()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        searchBar.backgroundColor = .systemBlue
        searchBar.placeholder = "Search city..."
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 100)
        ])

        searchBar.rx.text.debounce(.milliseconds(UIConstants.debounceTime), scheduler: MainScheduler.instance)
                .subscribe(onNext:
                { [self] in
                    if let city = $0 { getListOfCities(city: city) }
                })
                .disposed(by: disposeBag)

//        searchResultsTableView = UITableView()
//        view.addSubview(searchResultsTableView)

//        NSLayoutConstraint.activate([
//            searchResultsTableView.leftAnchor.constraint(equalTo: searchBar.layoutMarginsGuide.leftAnchor),
//            searchResultsTableView.topAnchor.constraint(equalTo: searchBar.layoutMarginsGuide.bottomAnchor),
//            searchResultsTableView.rightAnchor.constraint(equalTo: searchBar.layoutMarginsGuide.rightAnchor),
//            searchResultsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
//        ])


        let barHeight: CGFloat = 200//searchBar.frame.maxY
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
//
        searchResultsTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        self.view.addSubview(searchResultsTableView)
        searchResultsTableView.backgroundColor = .systemBlue



    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(locationsArray[indexPath.row].key)")
        let storyboard = UIStoryboard(name: "WeatherDetails", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "weatherDetailsVcId") as! WeatherDetailsViewController
        vc.cityKey = locationsArray[indexPath.row].key
        vc.cityName = locationsArray[indexPath.row].localizedName
        present(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(locationsArray[indexPath.row].localizedName ?? ""), \(locationsArray[indexPath.row].countryName ?? "")"
        return cell
    }



}




extension MainViewController {
    func getListOfCities(city: String)
    {
        NetworkRepository.getCitiesMatchingName(city: city).subscribe(onNext: { [self] locations in
                    self.locationsArray.removeAll()
                    locations.forEach
                    {
                        print("getListOfCities = " + ($0.localizedName ?? "") + ", " + ($0.countryName ?? "NO COUNTRY"))
                        self.locationsArray.append($0)
                    }
                    searchResultsTableView.reloadData()

                }/*,
                onError: { (error) in print(error.localizedDescription  + " YIU")}*/
                )
                .disposed(by: disposeBag)
    }



}

