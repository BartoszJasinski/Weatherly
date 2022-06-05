//
// Created by ITT on 04/06/2022.
//

import Foundation

public class NetworkRepository {
    let baseURL = URL(string: "https://api.printful.com/countries")!
    var method = RequestType.GET
    var parameters = [String: String]()

    func request(with baseURL: URL) -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}