//
//  ViewController.swift
//  Weatherly
//
//  Created by ITT on 04/06/2022.
//

import UIKit

class ViewController: UIViewController {
        
//    var avPlayer: AVPlayer!
//    var avPlayerLayer: AVPlayerLayer!
    var searchBar: UISearchBar!

    override func loadView() {
        super.loadView()
        print("ABC")





        setupView()
        setupSearchBar()

        print("XYZ")

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        playBackgroundVideo()
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
extension ViewController {
    private func setupView() {
        view = UIView()
        view.backgroundColor = .systemGreen
    }

    private func setupSearchBar() {
        searchBar = UISearchBar()
//        searchBar.sizeToFit()
//        navigationItem.titleView = searchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = .systemBlue
//        searchBar.round()
        searchBar.placeholder = "Search city..."

//        if #available(iOS 13.0, *) {
//            searchBar.searchTextField.layer.cornerRadius = UIConstants.cornerRadius
//            searchBar.searchTextField.clipsToBounds = true
//        }




        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.blue
            if let backgroundview = textfield.subviews.first {
                // Background color
                backgroundview.backgroundColor = UIColor.green
                // Rounded corner
                backgroundview.layer.cornerRadius = 14;
                backgroundview.clipsToBounds = true;
            }
        }
        view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        ])
    }
}

