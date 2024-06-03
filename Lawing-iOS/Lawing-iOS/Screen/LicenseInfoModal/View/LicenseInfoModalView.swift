//
//  LicenseInfoModalView.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

import SnapKit
import Then

final class LicenseInfoModalView: UIView {
    
    //MARK: - Properties
    
    typealias RegisterLicenseButtonAction = () -> Void

    private var registerLicenseButtonAction: RegisterLicenseButtonAction?

    //MARK: - UI Properties
    
    private let titleLabel = UILabel()
    private let licenseImageView = UIImageView()
    private let registerLicenseButton = UIButton()
    
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

extension LicenseInfoModalView {
    
    //MARK: - targetView Method
    
    func setupregisterLicenseButton(action: @escaping RegisterLicenseButtonAction) {
        registerLicenseButtonAction = action
        registerLicenseButton.addTarget(self, action: #selector(registerLicenseButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .lawingWhite
        
        licenseImageView.backgroundColor = .lightGray
        
        titleLabel.do {
            $0.text = "로잉을 이용하기 위해서는\n운전 면허증 등록이 필수입니다!"
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.font = .titleSemiBold
        }
        
        registerLicenseButton.do {
            $0.backgroundColor = .lawingGreen
            $0.setTitle("운전 면허증 등록하러 가기", for: .normal)
            $0.setTitleColor(.lawingBlack, for: .normal)
            $0.titleLabel?.font = .button1Bold
            $0.makeRounded(radius: 15)
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            titleLabel,
            licenseImageView,
            registerLicenseButton
        )
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.centerX.equalToSuperview()
        }
        
        licenseImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview().inset(70)
            $0.height.equalTo(110)
        }
        
        registerLicenseButton.snp.makeConstraints {
            $0.top.equalTo(licenseImageView.snp.bottom).offset(29)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(56)
            $0.width.equalTo(335)
        }
    }
    
    //MARK: - @Objc Method
    
    @objc private func registerLicenseButtonTapped() {
        registerLicenseButtonAction?()
    }
}
