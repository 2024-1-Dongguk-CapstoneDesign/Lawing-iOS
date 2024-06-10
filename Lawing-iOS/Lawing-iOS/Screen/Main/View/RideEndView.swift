//
//  RideEndView.swift
//  Lawing-iOS
//
//  Created by 김다예 on 6/6/24.
//

import UIKit

enum RideEndType {
    case helmet
    case multiplePeople
    case velocity
    
    var title: String {
        switch self {
        case .helmet: return "헬멧이 감지되지 않습니다!"
        case .multiplePeople: return "다중 인원 탑승이 감지됩니다!"
        case .velocity: return "과속이 감지됩니다!\n감속하지 않을 시"
        }
    }
}

final class RideEndView: UIView {
    
    private let viewType: RideEndType
    
    private let stackView: UIStackView = UIStackView()
    private let warningImageView: UIImageView = UIImageView(image: .warning)
    private let warningLabel: UILabel = UILabel()
    private let timerLabel: UILabel = UILabel()
    
    var timer: Timer?
    var secondsRemaining = 20 {
        didSet {
            timerLabel.text = "\(secondsRemaining)"
        }
    }
    
    init(frame: CGRect, type: RideEndType) {
        viewType = type
        
        super.init(frame: frame)
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RideEndView {
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self, selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
        
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
        } else {
            timer?.invalidate()
            secondsRemaining = 0
        }
    }
}

private extension RideEndView {
    func setupStyle() {
        makeRounded(radius: 40)
        backgroundColor = .lawingWhite
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = 14
            $0.alignment = .center
        }
        
        warningLabel.do {
            $0.text = "\(viewType.title)\n20초 후 패널티가 부과됩니다."
            $0.font = .caption2SemiBold
            $0.textColor = .black
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
        
        timerLabel.do {
            $0.text = "20"
            $0.font = .head1ExtraBold
            $0.textColor = .black
        }
    }
    
    func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubviews(warningImageView, warningLabel, timerLabel)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
