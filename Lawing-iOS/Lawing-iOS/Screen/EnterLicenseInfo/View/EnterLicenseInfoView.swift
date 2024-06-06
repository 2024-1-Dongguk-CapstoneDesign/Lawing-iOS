//
//  EnterLicenseInfoView.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/15/24.
//

import UIKit

import SnapKit
import Then

final class EnterLicenseInfoView: UIView {
    
    //MARK: - Properties
    
    typealias ShowPickerButtonAction = () -> Void
    typealias ClearButtonAction = (_ button: UIButton) -> Void
    typealias RegisterButtonAction = () -> Void
    typealias CameraButtonAction = () -> Void

    private var showPickerButtonAction: ShowPickerButtonAction?
    private var clearButtonAction: ClearButtonAction?
    private var registerButtonAction: RegisterButtonAction?
    private var cameraButtonAction: CameraButtonAction?
    //MARK: - UI Properties
    
    private let titleLabel = UILabel()
    let regionTextField = UITextField()
    private let showPickerButton = UIButton()
    let regionPickerView = UIPickerView()
    let licenseNumberTextField = UITextField()
    private let nameLabel = UILabel()
    let nameTextField = UITextField()
    private let serialNumberLabel = UILabel()
    let serialNumberTextField = UITextField()
    private let socialSecurityNumberLabel = UILabel()
    let socialSecurityNumberFirstTextField = UITextField()
    private let socialSecurityNumberSecondTextField = UITextField()
    private let circleStackView = UIStackView()
    private let cameraButton = UIButton()
    private let checkButton = UIButton()
    private let consentLabel = UILabel ()
    private let viewMoreButton = UIButton()
    private let registerButton = UIButton()
    
    private let clearButton: [UIButton] = {
        var buttons = [UIButton]()
        
        for i in 1...4 {
            let button = UIButton()
            
            button.setImage(UIImage(resource: .clearBtnIcon), for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 20, height: 22)
            button.tag = i
            
            buttons.append(button)
        }
        
        return buttons
    }()
    
    private let securityCircleView: [UIView] = {
        var views = [UIView]()
        
        for i in 0..<6 {
            let view = UIView()
            view.snp.makeConstraints { $0.width.height.equalTo(12) }
            view.makeRounded(radius: 6)
            view.backgroundColor = .lawingGray3
            
            views.append(view)
        }
        
        return views
    }()
    
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

extension EnterLicenseInfoView {
    
    //MARK: - targetView Method
    
    func setTextFieldDelegate(_ viewController: UITextFieldDelegate) {
        regionTextField.delegate = viewController
        licenseNumberTextField.delegate = viewController
        nameTextField.delegate = viewController
        serialNumberTextField.delegate = viewController
        socialSecurityNumberFirstTextField.delegate = viewController
        socialSecurityNumberSecondTextField.delegate = viewController
    }
    
    func setPickerViewDelegate(_ viewController: UIViewController) {
        regionPickerView.delegate = viewController as? UIPickerViewDelegate
        regionPickerView.dataSource = viewController as? UIPickerViewDataSource
    }
    
    func setupShowPickerButton(action: @escaping ShowPickerButtonAction) {
        showPickerButtonAction = action
        showPickerButton.addTarget(self, action: #selector(showPickerButtonTapped), for: .touchUpInside)
    }
    
    func setupClearButton(action: @escaping ClearButtonAction) {
        clearButtonAction = action
        for button in clearButton {
            button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        }
    }
    
    func setupregisterLicenseButton(action: @escaping RegisterButtonAction) {
        registerButtonAction = action
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    func setupCameraButton(action: @escaping CameraButtonAction) {
        cameraButtonAction = action
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private Method
    
    private func setupStyle() {
        self.backgroundColor = .lawingWhite
        
        titleLabel.do {
            $0.text = "면허 정보 입력"
            $0.font = .titleSemiBold
            $0.textColor = .lawingBlack
        }
        
        showPickerButton.do {
            $0.setImage(UIImage(resource: .arrowDown), for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: 20, height: 22)
        }
        
        regionTextField.do {
            $0.setUnderline(forBackGroundColor: .lawingWhite, forUnderLineColor: .lawingGray1, forWidth: 2)
            $0.setPlaceholder(placeholder: "지역", fontColor: .lawingGray1, font: .caption3Medium)
            $0.setTextFont(forFont: .caption3Medium, forFontColor: .lawingBlack)
            $0.addPadding(left: 8)
            $0.tag = 0
            
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 22))
            rightView.addSubview(showPickerButton)
            $0.rightViewMode = .always
            $0.rightView = rightView
        }
        
        licenseNumberTextField.do {
            $0.setUnderline(forBackGroundColor: .lawingWhite, forUnderLineColor: .lawingGray1, forWidth: 2)
            $0.setTextFont(forFont: .caption2Medium, forFontColor: .lawingBlack)
            $0.setPlaceholder(placeholder: "면허 번호 10자리", fontColor: .lawingGray1, font: .caption3Medium)
            $0.addPadding(left: 8)
            $0.tag = 1
        }
        
        nameLabel.do {
            $0.text = "이름"
            $0.font = .caption3Medium
            $0.textColor = .lawingGray1
            $0.textAlignment = .center
        }
        
        nameTextField.do {
            $0.setUnderline(forBackGroundColor: .lawingWhite, forUnderLineColor: .lawingGray1, forWidth: 2)
            $0.setTextFont(forFont: .caption2Medium, forFontColor: .lawingBlack)
            $0.addPadding(left: 8)
            $0.tag = 2
        }
        
        serialNumberLabel.do {
            $0.text = "시리얼 번호"
            $0.font = .caption3Medium
            $0.textColor = .lawingGray1
            $0.textAlignment = .center
        }
        
        serialNumberTextField.do {
            $0.setUnderline(forBackGroundColor: .lawingWhite, forUnderLineColor: .lawingGray1, forWidth: 2)
            $0.setTextFont(forFont: .caption2Medium, forFontColor: .lawingBlack)
            $0.addPadding(left: 8)
            $0.tag = 3
        }
        
        socialSecurityNumberLabel.do {
            $0.text = "주민등록번호"
            $0.font = .caption3Medium
            $0.textColor = .lawingGray1
            $0.textAlignment = .center
        }
        
        socialSecurityNumberFirstTextField.do {
            $0.setUnderline(forBackGroundColor: .lawingWhite, forUnderLineColor: .lawingGray1, forWidth: 2)
            $0.setTextFont(forFont: .caption2Medium, forFontColor: .lawingBlack)
            $0.addPadding(left: 8)
            $0.tag = 4
        }
        
        socialSecurityNumberSecondTextField.do {
            $0.setUnderline(forBackGroundColor: .lawingWhite, forUnderLineColor: .lawingGray1, forWidth: 2)
            $0.setTextFont(forFont: .caption2Medium, forFontColor: .lawingBlack)
            $0.addPadding(left: 8)
            $0.tag = 5
        }
        
        for textField in [licenseNumberTextField, nameTextField, serialNumberTextField, socialSecurityNumberFirstTextField] {
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 22))
            rightView.addSubview(clearButton[textField.tag - 1])
            textField.rightViewMode = .never
            textField.rightView = rightView
        }
        
        circleStackView.do {
            $0.axis = .horizontal
            $0.spacing = 9
        }
        
        cameraButton.do {
            $0.backgroundColor = .lawingGreen
            $0.setTitle("카메라로 인식하여 입력하기", for: .normal)
            $0.setTitleColor(.lawingBlack, for: .normal)
            $0.titleLabel?.font = .button2SemiBold
            $0.makeRounded(radius: 15)
        }
        
        checkButton.do {
            $0.setImage(UIImage(resource: .checkNormalIcon), for: .normal)
        }
        
        consentLabel.do {
            $0.text = "[필수] 개인정보 수집 및 이용 동의"
            $0.font = .caption3Medium
            $0.textColor = .lawingGray1
        }
        
        viewMoreButton.do {
            $0.setImage(UIImage(resource: .arrowRight), for: .normal)
        }
        
        registerButton.do {
            $0.backgroundColor = .lawingGreen
            $0.setTitle("등록하기", for: .normal)
            $0.setTitleColor(.lawingBlack, for: .normal)
            $0.makeRounded(radius: 15)
            $0.titleLabel?.font = .button1Bold
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews(
            titleLabel,
            regionTextField,
            showPickerButton,
            licenseNumberTextField,
            nameLabel,
            nameTextField,
            serialNumberLabel,
            serialNumberTextField,
            socialSecurityNumberLabel,
            socialSecurityNumberFirstTextField,
            socialSecurityNumberSecondTextField,
            circleStackView,
            cameraButton,
            checkButton,
            consentLabel,
            viewMoreButton,
            registerButton
        )
        
        for i in 0..<6 {
            circleStackView.addArrangedSubview(securityCircleView[i])
        }
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(49)
            $0.centerX.equalToSuperview()
        }
        
        regionTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(39)
            $0.leading.equalToSuperview().inset(26)
            $0.height.equalTo(41)
            $0.width.equalTo(180)
        }
        
        licenseNumberTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(39)
            $0.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(41)
            $0.width.equalTo(140)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(regionTextField.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(26)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(26)
            $0.height.equalTo(41)
            $0.width.equalTo(150)
        }
        
        serialNumberLabel.snp.makeConstraints {
            $0.top.equalTo(regionTextField.snp.bottom).offset(50)
            $0.leading.equalTo(serialNumberTextField)
        }
        
        serialNumberTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(7)
            $0.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(41)
            $0.width.equalTo(160)
        }
        
        socialSecurityNumberLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(26)
        }
        
        socialSecurityNumberFirstTextField.snp.makeConstraints {
            $0.top.equalTo(socialSecurityNumberLabel.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(26)
            $0.height.equalTo(41)
            $0.width.equalTo(150)
        }
        
        socialSecurityNumberSecondTextField.snp.makeConstraints {
            $0.top.equalTo(socialSecurityNumberLabel.snp.bottom).offset(7)
            $0.leading.equalTo(socialSecurityNumberFirstTextField.snp.trailing).offset(31)
            $0.height.equalTo(41)
            $0.width.equalTo(31)
        }
        
        circleStackView.snp.makeConstraints {
            $0.top.equalTo(socialSecurityNumberLabel.snp.bottom).offset(21)
            $0.leading.equalTo(socialSecurityNumberSecondTextField.snp.trailing).offset(5)
        }
        
        cameraButton.snp.makeConstraints {
            $0.top.equalTo(socialSecurityNumberFirstTextField.snp.bottom).offset(44)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(159)
            $0.height.equalTo(32)
        }
        
        checkButton.snp.makeConstraints {
            $0.bottom.equalTo(registerButton.snp.top).offset(-29)
            $0.leading.equalToSuperview().inset(43)
            $0.height.equalTo(10)
            $0.width.equalTo(15)
        }
        
        consentLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkButton.snp.centerY)
            $0.leading.equalTo(checkButton.snp.trailing).offset(15)
        }
        
        viewMoreButton.snp.makeConstraints {
            $0.centerY.equalTo(checkButton.snp.centerY)
            $0.trailing.equalToSuperview().inset(40)
        }
        
        registerButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(29)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(23)
            $0.height.equalTo(56)
        }
    }
    
    //MARK: - Method
    
    func setTextFieldInitialState(textFieldTag: Int) {
        switch textFieldTag {
        case 1:
            licenseNumberTextField.text = ""
            licenseNumberTextField.rightViewMode = .never
        case 2:
            nameTextField.text = ""
            nameTextField.rightViewMode = .never
        case 3:
            serialNumberTextField.text = ""
            serialNumberTextField.rightViewMode = .never
        case 4:
            socialSecurityNumberFirstTextField.text = ""
            socialSecurityNumberFirstTextField.rightViewMode = .never
        default:
            return
        }
    }
    
    func setLabelTextColor(textFieldTag: Int, isEditing: Bool) {
        switch textFieldTag {
        case 2:
            isEditing ? (nameLabel.textColor = .lawingGray3) : (nameLabel.textColor = .lawingGray1)
        case 3:
            isEditing ? (serialNumberLabel.textColor = .lawingGray3) : (serialNumberLabel.textColor = .lawingGray1)
        case 4:
            isEditing ? (socialSecurityNumberLabel.textColor = .lawingGray3) : (socialSecurityNumberLabel.textColor = .lawingGray1)
        default: return
        }
    }
    
    //MARK: - @Objc Method

    @objc private func showPickerButtonTapped() {
        showPickerButtonAction?()
    }
    
    @objc private func clearButtonTapped(_ button: UIButton) {
        clearButtonAction?(button)
    }
    
    @objc private func registerButtonTapped() {
        registerButtonAction?()
    }
    
    @objc private func cameraButtonTapped() {
        cameraButtonAction?()
    }
}
