//
// Created by ITT on 04/06/2022.
//

import Foundation
import RxSwift


public class NetworkService {
    // create a method for calling api which is return a Observable
//    func send<T: Codable>(apiRequest: NetworkRepository) -> Observable<T> {
//        Observable<T>.create { observer in
//            let request = apiRequest.request(with: apiRequest.baseURL)
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                do {
//                    let model: countryModel = try JSONDecoder().decode(countryModel.self, from: data ?? Data())
//                    observer.onNext( model.result as! T)
//                } catch let error {
//                    observer.onError(error)
//                }
//                observer.onCompleted()
//            }
//            task.resume()
//
//            return Disposables.create {
//                task.cancel()
//            }
//        }
//    }
}


public enum RequestType: String {
    case GET, POST, PUT,DELETE
}