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
    
    typealias RetryFaceIDButtonAction = () -> Void

    private var retryFaceIDButtonAction: RetryFaceIDButtonAction?

    //MARK: - UI Properties
    
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
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
    
    func setupretryFaceIDButton(action: @escaping RetryFaceIDButtonAction) {
        retryFaceIDButtonAction = action
        retryFaceIDButton.addTarget(self, action: #selector(retryFaceIDButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .lawingWhite
        
        logoImageView.backgroundColor = .lightGray
        
        titleLabel.do {
            $0.text = "로잉을 이용하기 위해서는\n인증이 필요합니다!"
            $0.numberOfLines = 2
            $0.textAlignment = .center
            $0.font = .titleSemiBold
        }
        
        retryFaceIDButton.do {
            $0.backgroundColor = .lawingGreen
            $0.setTitle("Face ID 다시 시도하기", for: .normal)
            $0.setTitleColor(.lawingBlack, for: .normal)
            $0.titleLabel?.font = .button1Bold
            $0.makeRounded(radius: 15)
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            logoImageView,
            titleLabel,
            retryFaceIDButton
        )
    }
    
    private func setupLayout() {
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(180)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(149)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
        
        retryFaceIDButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(39)
            $0.height.equalTo(56)
        }
    }
    
    //MARK: - @Objc Method
    
    @objc private func retryFaceIDButtonTapped() {
        retryFaceIDButtonAction?()
    }
}
