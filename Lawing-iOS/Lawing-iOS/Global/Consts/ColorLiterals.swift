//
//  ColorLiterals.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/8/24.
//

import UIKit

extension UIColor {
    
    static var lawingGreen: UIColor {
        return UIColor(hex: "#C1EB83")
    }
    
    static var lawingRed: UIColor {
        return UIColor(hex: "#FF6161")
    }
    
    static var lawingBlack: UIColor {
        return UIColor(hex: "#090909")
    }
    
    static var lawingWhite: UIColor {
        return UIColor(hex: "#FFFFFF")
    }
    
    static var lawingGrey3: UIColor {
        return UIColor(hex: "#898A8D")
    }
    
    static var lawingGray2: UIColor {
        return UIColor(hex: "#898989")
    }
    
    static var lawingGray1: UIColor {
        return UIColor(hex: "#DEDEDE")
    }
    
    static var kakaoYellow: UIColor {
        return UIColor(hex: "#FFDE32")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
