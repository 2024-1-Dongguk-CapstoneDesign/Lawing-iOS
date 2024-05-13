//
//  LoginMainView.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

import SnapKit
import Then

final class LoginMainView: UIView {
    
    //MARK: - Properties
    
    typealias LoginButtonAction = () -> Void
    typealias KakaoButtonAction = () -> Void

    private var loginButtonAction: LoginButtonAction?
    private var kakaoButtonAction: KakaoButtonAction?

    //MARK: - UI Properties
    
    private let onboardingImageView = UIImageView()
    private let loginButton = UIButton()
    private let createAccountLabel = UILabel()
    private let kakaoButton = UIButton()
    
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

extension LoginMainView {
    
    //MARK: - targetView Method
    
    func setupLoginButton(action: @escaping LoginButtonAction) {
        loginButtonAction = action
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func setupKakaoButton(action: @escaping KakaoButtonAction) {
        kakaoButtonAction = action
        kakaoButton.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .lawingWhite
        
        onboardingImageView.backgroundColor = .lightGray
        
        loginButton.do {
            $0.backgroundColor = .lawingGreen
            $0.setTitle("로그인 하기", for: .normal)
            $0.setTitleColor(.lawingBlack, for: .normal)
            $0.titleLabel?.font = .button1Bold
            $0.makeRounded(radius: 15)
        }
        
        createAccountLabel.do {
            $0.text = "계정이 없으신가요?"
            $0.textColor = .lawingGray2
            $0.font = .caption3SemiBold
            $0.textAlignment = .center
            $0.underLineText(forText: $0.text ?? "")
        }
        
        kakaoButton.do {
            $0.backgroundColor = .kakaoYellow
            $0.setTitle("카카오 계정으로 계속하기", for: .normal)
            $0.setTitleColor(.lawingBlack, for: .normal)
            $0.titleLabel?.font = .button1Bold
            $0.makeRounded(radius: 15)
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            onboardingImageView,
            loginButton,
            createAccountLabel,
            kakaoButton
        )
    }
    
    private func setupLayout() {
        onboardingImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(29)
            $0.horizontalEdges.equalToSuperview().inset(31)
            $0.height.equalTo(440)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(onboardingImageView.snp.bottom).offset(26)
            $0.horizontalEdges.equalToSuperview().inset(39)
            $0.height.equalTo(56)
        }
        
        createAccountLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints {
            $0.top.equalTo(createAccountLabel.snp.bottom).offset(11)
            $0.horizontalEdges.equalToSuperview().inset(39)
            $0.height.equalTo(56)
        }
    }
    
    //MARK: - @Objc Method
    
    @objc private func loginButtonTapped() {
        loginButtonAction?()
    }
    
    @objc private func kakaoButtonTapped() {
        kakaoButtonAction?()
    }
}
