//
//  UIView.swift
//  BookingApp
//
//  Created by Mehdi on 2024-05-21.
//

import UIKit

extension UIView {
    var snapshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
