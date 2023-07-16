//
//  urlString.swift
//  FitnessCalulator
//
//  Created by MAG on 14/07/2023.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}

