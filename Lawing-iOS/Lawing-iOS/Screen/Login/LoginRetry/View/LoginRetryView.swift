//
//  LoginRetryView.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

import SnapKit
import Then

final class LoginRetryView: UIView {
    
    //MARK: - Properties
    
    typealias KakaoButtonAction = () -> Void
    typealias RetryFaceIDButtonAction = () -> Void

    private var kakaoButtonAction: KakaoButtonAction?
    private var retryFaceIDButtonAction: KakaoButtonAction?

    //MARK: - UI Properties
    
    private let logoImageView = UIImageView()
    private let kakaoButton = UIButton()
    private let retryFaceIDButton = UIButton()
    
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

extension LoginRetryView {
    
    //MARK: - targetView Method
    
    func setupKakaoButton(action: @escaping KakaoButtonAction) {
        kakaoButtonAction = action
        kakaoButton.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
    }
    
    func setupretryFaceIDButton(action: @escaping RetryFaceIDButtonAction) {
        retryFaceIDButtonAction = action
        retryFaceIDButton.addTarget(self, action: #selector(retryFaceIDButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .lawingWhite
        
        logoImageView.backgroundColor = .lightGray
        
        kakaoButton.do {
            $0.backgroundColor = .kakaoYellow
            $0.setTitle("카카오 계정으로 계속하기", for: .normal)
            $0.setTitleColor(.lawingBlack, for: .normal)
            $0.titleLabel?.font = .button1Bold
            $0.makeRounded(radius: 15)
        }
        
        retryFaceIDButton.do {
            $0.setTitle("Face ID 다시 시도하기", for: .normal)
            $0.underlineTitle(forTitle: $0.titleLabel?.text ?? "")
            $0.setTitleColor(.lawingGray2, for: .normal)
            $0.titleLabel?.font = .caption3SemiBold
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            logoImageView,
            kakaoButton,
            retryFaceIDButton
        )
    }
    
    private func setupLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(227)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(149)
        }
        
        kakaoButton.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(65)
            $0.horizontalEdges.equalToSuperview().inset(39)
            $0.height.equalTo(56)
        }
        
        retryFaceIDButton.snp.makeConstraints {
            $0.top.equalTo(kakaoButton.snp.bottom).offset(34)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(14)
            $0.width.equalTo(128)
        }
    }
    
    //MARK: - @Objc Method
    
    @objc private func kakaoButtonTapped() {
        kakaoButtonAction?()
    }
    
    @objc private func retryFaceIDButtonTapped() {
        retryFaceIDButtonAction?()
    }
}
