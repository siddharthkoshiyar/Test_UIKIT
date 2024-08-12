//
//  UIView+Extension.swift
//  SwiftUIKitDemo
//
//  Created by SIDDHARTH KOSHIYAR on 12/08/24.
//

import Foundation
import UIKit

// MARK: - Properties
public extension UIView {
    
    /// Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            //            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
}
