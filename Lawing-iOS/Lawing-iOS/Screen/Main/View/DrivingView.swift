//
//  DrivingView.swift
//  Lawing-iOS
//
//  Created by 김다예 on 6/9/24.
//

import UIKit

final class DrivingView: UIView {

    let velocityView: VelocityView = VelocityView()
    let multiFaceWarningView: RideEndView = RideEndView(frame: .zero, type: .multiplePeople)
    let helmetWarningView: RideEndView = RideEndView(frame: .zero, type: .helmet)
    let velocityWarningView: RideEndView = RideEndView(frame: .zero, type: .velocity)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DrivingView {
    func warningView(warningType: RideEndType) {
        switch warningType {
        case .multiplePeople:
            multiFaceWarningView.isHidden = false
            helmetWarningView.isHidden = true
            velocityWarningView.isHidden = true
            multiFaceWarningView.startTimer()
        case .helmet:
            multiFaceWarningView.isHidden = true
            helmetWarningView.isHidden = false
            velocityWarningView.isHidden = true
            helmetWarningView.startTimer()
        case .velocity:
            multiFaceWarningView.isHidden = true
            helmetWarningView.isHidden = true
            velocityWarningView.isHidden = false
            velocityWarningView.startTimer()
        }
    }
}

private extension DrivingView {
    func setupStyle() {
        backgroundColor = .lawingBlack.withAlphaComponent(0.5)
        
        multiFaceWarningView.isHidden = true
        helmetWarningView.isHidden = true
        velocityWarningView.isHidden = true
    }
    
    func setupLayout() {
        addSubviews(velocityView,
                    multiFaceWarningView,
                    helmetWarningView,
                    velocityWarningView)
        
        velocityView.snp.makeConstraints {
            $0.height.equalTo(94)
            $0.bottom.equalToSuperview().inset(42)
            $0.horizontalEdges.equalToSuperview().inset(18)
        }
        
        [multiFaceWarningView,
         helmetWarningView].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(210)
                $0.horizontalEdges.equalToSuperview().inset(18)
                $0.bottom.equalTo(velocityView.snp.top).offset(-20)
            }
        }
        
        velocityWarningView.snp.makeConstraints {
            $0.height.equalTo(180)
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.bottom.equalTo(velocityView.snp.top).offset(-20)
        }
    }
}

