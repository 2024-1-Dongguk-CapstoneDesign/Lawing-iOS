//
//  WelcomeView.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

import SnapKit
import Then

final class WelcomeView: UIView {

    //MARK: - UI Properties
    
    private let titleLabel = UILabel()
    private let welcomeImageView = UIImageView()
    private let subTitleLabel = UILabel()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WelcomeView {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .lawingWhite
        
        welcomeImageView.backgroundColor = .lightGray
        
        titleLabel.do {
            $0.text = "환영합니다!"
            $0.textAlignment = .center
            $0.font = .titleSemiBold
        }
        
        subTitleLabel.do {
            $0.text = "계정 생성이 완료되었습니다."
            $0.textAlignment = .center
            $0.font = .titleSemiBold
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            titleLabel,
            welcomeImageView,
            subTitleLabel
        )
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(119)
            $0.centerX.equalToSuperview()
        }
        
        welcomeImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(55)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(149)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeImageView.snp.bottom).offset(55)
            $0.centerX.equalToSuperview()
        }
    }
}
