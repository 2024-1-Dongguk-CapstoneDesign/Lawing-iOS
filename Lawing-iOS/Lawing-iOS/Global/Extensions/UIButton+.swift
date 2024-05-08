//
//  UIButton+.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/8/24.
//

import UIKit

extension UIButton {
    func animateButton() {
        
        UIView.animate(withDuration: 0.015) {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        } completion: { _ in
            UIView.animate(withDuration: 0.05) {
                self.transform = .identity
            }
        }
    }
    
    /// 특정 button의 title에 underline을 추가하는 함수
    /// > 사용 예시 : button.underlineTitle(forTitle: "키워드 초기화")
    func underlineTitle(forTitle: String) {
        let attributedTitle = NSMutableAttributedString(string: forTitle)
        attributedTitle.addAttribute(.underlineStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSRange(location: 0, length: forTitle.count))
        
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
