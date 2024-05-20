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
    }
    
    private func registerLicenseButtonTapped() {
        print("registerLicenseButtonTapped")
    }
}
