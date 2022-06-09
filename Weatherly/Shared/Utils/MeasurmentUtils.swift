//
// Created by ITT on 07/06/2022.
//

import Foundation

struct TemperatureUtils {

    static func convertTemperature(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit

        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)

        return measurementFormatter.string(from: output)
    }

    static func formatTemperature(temperature: String) -> String {
        temperature + "°"
    }

}