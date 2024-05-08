//
//  UILabel+.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/8/24.
//

import UIKit

extension UILabel {
    
    /// 특정 text에 underline을 추가하는 함수
    /// > 사용 예시 : label.underLineText(forText: "맛집을 추천")
    func underLineText(forText: String) {
        guard let labelText = self.text else { return }
        
        let rangeToUnderLine = (labelText as NSString).range(of: forText)
        
        let underLineText = NSMutableAttributedString(string: labelText)
        underLineText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: rangeToUnderLine)
        
        self.attributedText = underLineText
    }
}
