//
//  Card_extension.swift
//  FitnessCalulator
//
//  Created by MAG on 13/07/2023.
//

import Foundation
import UIKit

extension UIView{
    @IBInspectable var cornerRaduis: CGFloat {
        get { return cornerRaduis }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
