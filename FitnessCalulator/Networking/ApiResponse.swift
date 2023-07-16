//
//  ApiResponse.swift
//  FitnessCalulator
//
//  Created by MAG on 14/07/2023.
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
