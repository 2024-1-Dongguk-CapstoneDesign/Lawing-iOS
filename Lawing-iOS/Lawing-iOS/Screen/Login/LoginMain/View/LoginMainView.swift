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
    
    typealias KakaoButtonAction = () -> Void
    
    private var kakaoButtonAction: KakaoButtonAction?

    //MARK: - UI Properties
    
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
    
    func setupKakaoButton(action: @escaping KakaoButtonAction) {
        kakaoButtonAction = action
        kakaoButton.addTarget(self, action: #selector(kakaoButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .lawingWhite
                
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
            createAccountLabel,
            kakaoButton
        )
    }
    
    private func setupLayout() {
        createAccountLabel.snp.makeConstraints {
            $0.bottom.equalTo(kakaoButton.snp.top).offset(-11)
            $0.centerX.equalToSuperview()
        }
        
        kakaoButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(39)
            $0.height.equalTo(56)
        }
    }
    
    //MARK: - @Objc Method
    
    @objc private func kakaoButtonTapped() {
        kakaoButtonAction?()
    }
}
