//
//  EnterLicenseInfoViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/15/24.
//

import UIKit

final class EnterLicenseInfoViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = EnterLicenseInfoView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        setTarget()
    }
}

extension EnterLicenseInfoViewController {
    
    // MARK: - Private Method
    
    private func setTarget() {
        rootView.setupregisterLicenseButton(action: registerLicenseButtonTapped)
        rootView.setupClearButton(action: clearButtonTapped)
    }
    
    private func registerLicenseButtonTapped() {
        print("registerLicenseButtonTapped")
    }
    
    private func clearButtonTapped(_ button: UIButton) {
        switch button.tag {
        case 1:
            rootView.setTextFieldInitialState(textFieldTag: 0)
        case 2:
            rootView.setTextFieldInitialState(textFieldTag: 1)
        case 3:
            rootView.setTextFieldInitialState(textFieldTag: 2)
        case 4:
            rootView.setTextFieldInitialState(textFieldTag: 3)
        default:
            return
        }
    }
}
