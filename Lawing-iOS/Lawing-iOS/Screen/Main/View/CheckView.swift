//
//  CheckView.swift
//  Lawing-iOS
//
//  Created by 김다예 on 6/6/24.
//

import UIKit

import SnapKit
import Then

final class CheckView: UIView {

    let title: String
    
    let textLabel: UILabel = UILabel()
    let checkImage: UIImageView = UIImageView(image: .checkGray)
    
    init(frame: CGRect, text: String) {
        self.title = text
        
        super.init(frame: frame)
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CheckView {
    func bindView(isCorrect: Bool) {
        if isCorrect {
            backgroundColor = .lawingGreen
            checkImage.image = .checkWhite
        } else {
            backgroundColor = .lawingWhite
            checkImage.image = .checkGray
        }
    }
}

private extension CheckView {
    func setupStyle() {
        makeRounded(radius: 23)
        backgroundColor = .lawingWhite
        layer.borderWidth = 2
        layer.borderColor = UIColor.lawingGray2.cgColor
        
        textLabel.do {
            $0.text = title
            $0.font = .caption2SemiBold
            $0.textColor = .black
        }
    }
    
    func setupLayout() {
        addSubviews(textLabel, checkImage)
        
        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        checkImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
