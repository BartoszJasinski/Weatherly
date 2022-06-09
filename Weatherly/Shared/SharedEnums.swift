//
// Created by ITT on 04/06/2022.
//

import UIKit


final class SharedEnums
{
    enum TemperatureMode
    {
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

        init(precipitation: String?) {
            switch precipitation {
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


        var icon: UIImage {
            switch self {
            case .sun: return UIImage(named: "sun.max.fill")!
            case .rain: return UIImage(named: "cloud.rain.fill")!
            case .cloud: return UIImage(named: "cloud.fill")!
            case .snow: return UIImage(named: "cloud.snow.fill")!
            case .ice: return UIImage(named: "cloud.snow.fill")!
            case .none: return  UIImage(named: "sun.min")!
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
