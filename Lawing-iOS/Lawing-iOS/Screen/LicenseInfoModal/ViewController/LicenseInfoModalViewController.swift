//
//  LicenseInfoModalViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

protocol dismissModalDelegate: AnyObject {
    func dismissModalAndPushViewController()
}

final class LicenseInfoModalViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: dismissModalDelegate?
    
    private let rootView = LicenseInfoModalView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
    }
}

extension LicenseInfoModalViewController {
    
    // MARK: - Private Method
    
    private func setTarget() {
        rootView.setupregisterLicenseButton(action: registerLicenseButtonTapped)
    }
    
    private func registerLicenseButtonTapped() {
        delegate?.dismissModalAndPushViewController()
        self.dismiss(animated: false)
    }
}
