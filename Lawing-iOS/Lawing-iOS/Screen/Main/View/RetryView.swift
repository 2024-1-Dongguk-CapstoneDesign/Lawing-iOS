//
//  RetryView.swift
//  Lawing-iOS
//
//  Created by 김다예 on 6/6/24.
//

import UIKit

enum RetryType {
    case helmet
    case multiplePeople
    
    var title: String {
        switch self {
        case .helmet: return "헬멧이 감지되지 않습니다."
        case .multiplePeople: return "다중 탑승이 감지됩니다."
        }
    }
}

final class RetryView: UIView {

    private let viewType: RetryType
    
    private let stackView: UIStackView = UIStackView()
    private let warningImageView: UIImageView = UIImageView(image: .warning)
    private let warningLabel: UILabel = UILabel()
    let retryButton: UIButton = UIButton()
    
    init(frame: CGRect, type: RetryType) {
        viewType = type
        super.init(frame: frame)
        
        setupStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RetryView {
    func bindView() {
        
    }
}

private extension RetryView {
    func setupStyle() {
        makeRounded(radius: 40)
        backgroundColor = .lawingWhite
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = 20
            $0.alignment = .center
        }
        
        warningLabel.do {
            $0.text = viewType.title
            $0.font = .caption2SemiBold
            $0.textColor = .black
        }
        
        retryButton.do {
            $0.setTitle("다시 시도하기", for: .normal)
            $0.setTitleColor(.lawingGray2, for: .normal)
            $0.titleLabel?.font = .caption3SemiBold
            $0.titleLabel?.underLineText(forText: "다시 시도하기")
        }
    }
    
    func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubviews(warningImageView,
                                      warningLabel,
                                      retryButton)
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
