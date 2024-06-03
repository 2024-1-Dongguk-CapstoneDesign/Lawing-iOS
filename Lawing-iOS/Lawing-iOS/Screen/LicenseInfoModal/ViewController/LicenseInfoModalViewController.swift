//
//  LicenseInfoModalViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

final class LicenseInfoModalViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = LicenseInfoModalView()
    
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

extension LicenseInfoModalViewController {
    
    // MARK: - Private Method
    
    private func setTarget() {
        rootView.setupregisterLicenseButton(action: registerLicenseButtonTapped)
    }
    
    private func registerLicenseButtonTapped() {
        print("registerLicenseButtonTapped")
    }
}
