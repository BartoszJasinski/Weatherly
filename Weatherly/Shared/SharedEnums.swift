//
// Created by ITT on 04/06/2022.
//

import UIKit


final class SharedEnums {

    enum TemperatureMode {
        case low
        case medium
        case high
        case none

        init(temperature: Double?) {
            if let temperature = temperature {
                if temperature < 10 {
                    self = .low
                } else if temperature < 20 {
                    self = .medium
                } else {
                    self = .high
                }
            } else {
                self = .none
            }
        }

        var color: UIColor {
            switch self {
            case .low: return .systemBlue
            case .medium: return .black
            case .high: return .red
            case .none: return .white
            }
        }

    }

    enum PrecipitationMode {
        case sun, rain, ice, cloud, snow, none

        // IT HAS TO BE DONE THIS WAY, BECAUSE NOT ALL PRECIPITATION STATES ARE HANDLED BY PrecipitationType FIELD SO I HAVE TO CHECK ADDITIONAL FIELDS
        init(precipitationType: String?) {
//            if IconPhrase


            switch precipitationType {
            case "Rain":
                self = .rain
            case "Snow":
                self = .snow
            case "Cloud":
                self = .cloud
            case "Ice":
                self = .ice
            default:
                self = .sun
            }
        }


        @available(iOS 13.0, *)
        var icon: UIImage {
            switch self {
            case .sun: return (UIImage(systemName: "sun.max")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal))!
            case .rain: return (UIImage(systemName: "cloud.rain")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal))!
            case .cloud: return (UIImage(systemName: "cloud")?.withTintColor(.white, renderingMode: .alwaysOriginal))!
            case .snow: return (UIImage(systemName: "snow")?.withTintColor(.white, renderingMode: .alwaysOriginal))!
            case .ice: return (UIImage(systemName: "snow")?.withTintColor(.white, renderingMode: .alwaysOriginal))!
            case .none: return  (UIImage(systemName: "sun.max")?.withTintColor(.white, renderingMode: .alwaysOriginal))!
            }
        }

        var backgroundImage: UIImage {
            switch self {
            case .sun: return UIImage(named: "sunnyImage")!
            case .rain: return UIImage(named: "rainyImage")!
            case .snow: return UIImage(named: "snowyImage")!
            case .ice: return UIImage(named: "snowyImage")!
            case .cloud: return UIImage(named: "cloudyImage")!
            case .none: return  UIImage(named: "sunnyImage")!
            }
        }


    }

}
