//
//  BeforeStartView.swift
//  Lawing-iOS
//
//  Created by 김다예 on 6/9/24.
//

import UIKit

import SnapKit
import Then

final class BeforeStartView: UIView {

    let checkMultiFaceView: CheckView = CheckView(frame: .zero,
                                                  text: "탑승 인원 감지")
    let checkHelmetView: CheckView = CheckView(frame: .zero,
                                                  text: "헬멧 착용 감지")
    
    let stateLabel: UILabel = UILabel()
    
    let retryMultiFaceView: RetryView = RetryView(frame: .zero,
                                                  type: .multiplePeople)
    let retryHelmetView: RetryView = RetryView(frame: .zero,
                                                  type: .helmet)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BeforeStartView {
    func setupMultiFace() {
        stateLabel.isHidden = false
        stateLabel.text = "탑승 인원을 확인 중입니다..."
        retryMultiFaceView.isHidden = true
    }
    
    func setupHelmet() {
        stateLabel.isHidden = false
        stateLabel.text = "헬멧 착용 여부를 확인 중입니다..."
        retryHelmetView.isHidden = true
    }
    
    func resultDetectMultiFace(isCorrect: Bool) {
        stateLabel.isHidden = true
        checkMultiFaceView.bindView(isCorrect: isCorrect)
        if !isCorrect {
            retryHelmetView.isHidden = true
            retryMultiFaceView.isHidden = false
        }
    }
    
    func resultDetectHelmet(isCorrect: Bool) {
        stateLabel.isHidden = true
        checkHelmetView.bindView(isCorrect: isCorrect)
        if !isCorrect {
            retryHelmetView.isHidden = false
            retryMultiFaceView.isHidden = true
        }
    }
    
    func correctAllState() {
        stateLabel.text = "전동 킥보드 이용이 가능합니다!"
        stateLabel.textColor = .systemGreen
        stateLabel.isHidden = false
        retryHelmetView.isHidden = true
        retryMultiFaceView.isHidden = true
    }
}

private extension BeforeStartView {
    func setupStyle() {
        
        backgroundColor = .lawingBlack.withAlphaComponent(0.7)
        stateLabel.do {
            $0.textColor = .lawingWhite
            $0.font = .caption2SemiBold
            $0.textAlignment = .center
        }
        
        stateLabel.isHidden = true
        retryHelmetView.isHidden = true
        retryMultiFaceView.isHidden = true
    }
    
    func setupLayout() {
        addSubviews(checkMultiFaceView,
                    checkHelmetView,
                    stateLabel,
                    retryMultiFaceView,
                    retryHelmetView)
        
        checkMultiFaceView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalToSuperview().inset(64)
            $0.horizontalEdges.equalToSuperview().inset(38)
        }
        
        checkHelmetView.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(checkMultiFaceView.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(38)
        }
        
        stateLabel.snp.makeConstraints {
            $0.top.equalTo(checkHelmetView.snp.bottom).offset(102)
            $0.centerX.equalToSuperview()
        }
        
        [retryMultiFaceView, retryHelmetView].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(162)
                $0.horizontalEdges.equalToSuperview().inset(18)
                $0.bottom.equalToSuperview().inset(40)
            }
        }
    }
}
