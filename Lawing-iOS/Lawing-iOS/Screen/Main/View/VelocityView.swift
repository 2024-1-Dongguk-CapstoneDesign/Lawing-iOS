//
//  VelocityView.swift
//  Lawing-iOS
//
//  Created by 김다예 on 6/6/24.
//

import UIKit

final class VelocityView: UIView {

    private let titleLabel: UILabel = UILabel()
    private let velocityLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VelocityView {
    func bindView(velocity: CGFloat) {
        if velocity < 0 {
            velocityLabel.text = "0km/h"
        }
        velocityLabel.text = "\(velocity)km/h"
    }
}

private extension VelocityView {
    func setupStyle() {
        makeRounded(radius: 40)
        backgroundColor = .lawingWhite
        layer.borderWidth = 3
        layer.borderColor = UIColor.lawingGreen.cgColor
        
        [titleLabel, velocityLabel].forEach {
            $0.do {
                $0.font = .caption1Bold
                $0.textColor = .lawingBlack
            }
        }
        
        titleLabel.text = "현재 속도"
    }
    
    func setupLayout() {
        addSubviews(titleLabel, velocityLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(30)
        }
        
        velocityLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
        }
    }
}
