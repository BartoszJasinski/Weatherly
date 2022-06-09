//
// Created by ITT on 07/06/2022.
//

import Foundation

struct TestData: Codable {
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case id
    }
}