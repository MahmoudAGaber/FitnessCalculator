//
//  Routes.swift
//  FitnessCalulator
//
//  Created by MAG on 14/07/2023.
//

import Foundation

enum Route {
    static let baseUrl = "https://fitness-calculator.p.rapidapi.com"
    case BMICalcualtor

    var description: String {
        switch self {
        case .BMICalcualtor:
            return "/bmi?age=25&gender=male&height=180&weight=70&activitylevel=level_1"

        }
    }
}
