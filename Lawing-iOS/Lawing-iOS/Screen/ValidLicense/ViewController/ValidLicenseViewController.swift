//
//  ValidLicenseViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 6/8/24.
//

import UIKit

final class ValidLicenseViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = ValidLicenseView()
    
    private var validResult = false
    private var errorMessege = ""
    
    // MARK: - Life Cycle
    
    init(result: Bool, description: String) {
        self.validResult = result
        self.errorMessege = description
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        setupTarget()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.rootView.setupUIWithValidState(state: self.validResult, errorMessege: self.fetcherrorMessege())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }
}

extension ValidLicenseViewController {
    
    // MARK: - Private Method
    
    private func setupTarget() {
        rootView.setupStartLawingButton(action: startLawingButtonTapped)
        rootView.setupRetryButton(action: retryButtonTapped)
    }
    
    private func fetcherrorMessege() -> (String) {
        switch errorMessege {
        case "LICENSE_MEMBER_INFO_NOT_CORRECT":
            return "회원 정보와 일치하지 않는 운전 면허증입니다."
        case "DRIVERS_LICENSE_EXISTS":
            return "이미 등록된 운전면허증입니다."
        case "LICENSE_OCR_FAILED":
            return "운전면허증 텍스트 추출을 실패하였습니다."
        case "LICENSE_VALIDATION_FAILED":
            return "유효하지 않은 운전면허증입니다."
        default:
            return ""
        }
    }
    
    private func startLawingButtonTapped() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    private func retryButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
