//
//  UITextField+.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/8/24.
//

import UIKit

extension UITextField {
    
    /// 텍스트필드 안쪽에 패딩 추가
    /// - Parameter left: 왼쪽에 추가할 패딩 너비
    /// - Parameter right: 오른쪽에 추가할 패딩 너비
    func addPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let leftPadding = left {
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 0))
            leftViewMode = .always
        }
        if let rightPadding = right {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 0))
            rightViewMode = .always
        }
    }
    
    func setPlaceholder(placeholder: String, fontColor: UIColor?, font: UIFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [.foregroundColor: fontColor!,
                                                                     .font: font])
    }
    
    func setTextFont(forFont: UIFont, forFontColor: UIColor) {
        self.font = forFont
        self.textColor = forFontColor
    }
    
    /// 자간 설정 메서드
    func setCharacterSpacing(_ spacing: CGFloat) {
        let attributedStr = NSMutableAttributedString(string: self.text ?? "")
        attributedStr.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, attributedStr.length))
        self.attributedText = attributedStr
    }
    
    func setUnderline(forBackGroundColor: UIColor, forUnderLineColor: UIColor, forWidth: CGFloat) {
        self.borderStyle = .none
        self.backgroundColor = forBackGroundColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = forUnderLineColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: forWidth)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
