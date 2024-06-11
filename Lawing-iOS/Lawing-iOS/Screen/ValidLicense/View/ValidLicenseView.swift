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
    
    //MARK: - Properties
    
    typealias StartLawingButtonAction = () -> Void
    typealias RetryButtonAction = () -> Void

    private var startLawingButtonAction: StartLawingButtonAction?
    private var retryButtonAction: RetryButtonAction?

    //MARK: - UI Properties
    
    private let descriptionLabel = UILabel()
    private let stateImageView = UIImageView()
    private let errorMessegeLabel = UILabel()
    private let startLawingButton = UIButton()
    private let retryButton = UIButton()

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
    
    //MARK: - TargetView Method
    
    func setupStartLawingButton(action: @escaping StartLawingButtonAction) {
        startLawingButtonAction = action
        startLawingButton.addTarget(self, action: #selector(startLawingButtonTapped), for: .touchUpInside)
    }
    
    func setupRetryButton(action: @escaping RetryButtonAction) {
        retryButtonAction = action
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .lawingWhite
        
        descriptionLabel.do {
            $0.text = "운전 면허증의 유효성을\n검사하는 중입니다..."
            $0.numberOfLines = 0
            $0.font = .titleSemiBold
            $0.textColor = .lawingBlack
            $0.textAlignment = .center
        }
        
        stateImageView.do {
            $0.image = .check
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
            $0.isHidden = true
        }
        
        retryButton.do {
            $0.backgroundColor = .lawingGray1
            $0.setTitle("재시도하기", for: .normal)
            $0.setTitleColor(.lawingBlack, for: .normal)
            $0.makeRounded(radius: 15)
            $0.titleLabel?.font = .button1Bold
            $0.isHidden = true
        }
    }
    
    private func setupHierarchy() {
        addSubviews(
            descriptionLabel,
            stateImageView,
            errorMessegeLabel,
            retryButton,
            startLawingButton
        )
    }
    
    private func setupLayout() {
        descriptionLabel.snp.makeConstraints {
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
        
        retryButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(29)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(56)
        }
    }
    
    // MARK: - Method
    
    func setupUIWithValidState(state: Bool, errorMessege: String) {
        if state {
            descriptionLabel.text  = "운면 면허증 등록이\n완료되었습니다!"
            stateImageView.image = .success
            startLawingButton.isHidden = false
        } else {
            descriptionLabel.text  = "운면 면허증을\n등록할 수 없습니다!"
            retryButton.isHidden = false
            stateImageView.image = .fail
            errorMessegeLabel.text = errorMessege
        }
    }
    
    //MARK: - @Objc Method

    @objc private func startLawingButtonTapped() {
        startLawingButtonAction?()
    }
    
    @objc private func retryButtonTapped() {
        retryButtonAction?()
    }
}
