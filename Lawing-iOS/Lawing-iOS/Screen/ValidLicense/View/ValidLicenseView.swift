//
//  ValidLicenseView.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 6/8/24.
//

import UIKit

import SnapKit
import Then

final class ValidLicenseView: UIView {

    //MARK: - UI Properties
    
    private let discriptionLabel = UILabel()
    private let stateImageView = UIImageView()
    private let errorMessegeLabel = UILabel()
    private let startLawingButton = UIButton()
    
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

extension ValidLicenseView {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .lawingWhite
        
        discriptionLabel.do {
            $0.numberOfLines = 0
            $0.font = .titleSemiBold
            $0.textColor = .lawingBlack
            $0.textAlignment = .center
        }
        
        stateImageView.do {
            $0.backgroundColor = .lawingGray1
        }
        
        errorMessegeLabel.do {
            $0.font = .caption2Medium
            $0.textColor = .lawingBlack
            $0.textAlignment = .center
        }
        
        startLawingButton.do {
            $0.backgroundColor = .lawingGreen
            $0.setTitle("로잉 시작하기", for: .normal)
            $0.setTitleColor(.lawingBlack, for: .normal)
            $0.makeRounded(radius: 15)
            $0.titleLabel?.font = .button1Bold
        }
    }
    
    private func setupHierarchy() {
        addSubviews(
            discriptionLabel,
            stateImageView,
            errorMessegeLabel,
            startLawingButton
        )
    }
    
    private func setupLayout() {
        discriptionLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(stateImageView.snp.top).offset(-36)
        }
        
        stateImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(158)
        }
        
        errorMessegeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(stateImageView.snp.bottom).offset(36)
        }
        
        startLawingButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(29)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(56)
        }
    }
}
