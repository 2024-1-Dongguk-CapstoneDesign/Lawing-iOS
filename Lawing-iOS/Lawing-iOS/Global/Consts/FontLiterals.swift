//
//  FontLiterals.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/8/24.
//

import UIKit

extension UIFont {
    
    // MARK: - head
    
    @nonobjc class var head1ExtraBold: UIFont {
        return UIFont.font(.pretendardExtraBold, ofSize: 30)
    }
    
    // MARK: - title
    
    @nonobjc class var titleSemiBold: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 22)
    }
    
    // MARK: - button
    
    @nonobjc class var button1Bold: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 18)
    }
    
    @nonobjc class var button2SemiBold: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 12)
    }
    
    // MARK: - caption

    @nonobjc class var caption1Bold: UIFont {
        return UIFont.font(.pretendardBold, ofSize: 24)
    }
    
    @nonobjc class var caption2SemiBold: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 17)
    }
    
    @nonobjc class var caption2Medium: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 17)
    }
    
    @nonobjc class var caption3SemiBold: UIFont {
        return UIFont.font(.pretendardSemiBold, ofSize: 14)
    }
    
    @nonobjc class var caption3Medium: UIFont {
        return UIFont.font(.pretendardMedium, ofSize: 14)
    }
    
}

enum FontName: String {
    case pretendardExtraBold = "Pretendard-ExtraBold"
    case pretendardBold = "Pretendard-Bold"
    case pretendardSemiBold = "Pretendard-SemiBold"
    case pretendardMedium = "Pretendard-Medium"
}

extension UIFont {
    static func font(_ style: FontName, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: style.rawValue, size: size)!
    }
}
