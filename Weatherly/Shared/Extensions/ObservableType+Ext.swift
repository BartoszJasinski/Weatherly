//
// Created by ITT on 12/06/2022.
//

import Foundation
import RxSwift
import ObjectMapper


extension ObservableType {
    public func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        flatMap { data -> Observable<T> in
            let json: AnyObject? = data as AnyObject
            guard let object = Mapper<T>().map(JSONObject: json) else {
                throw NSError(
                        domain: "",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                )
            }

            return Observable.just(object)
        }
    }

    public func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        flatMap { data -> Observable<[T]> in
            let json = data as AnyObject
            guard let objects = Mapper<T>().mapArray(JSONObject: json) else {
                throw NSError(
                        domain: "",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "ObjectMapper can't mapping"]
                )
            }

            return Observable.just(objects)
        }
    }
}