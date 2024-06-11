//
//  WelcomeViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = WelcomeView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
        presentLicenseInfoView()
    }
}

extension WelcomeViewController {
    
    // MARK: - Private Method
    
    private func presentLicenseInfoView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            let modalViewController = LicenseInfoModalViewController()
            modalViewController.delegate = self
            if let sheet = modalViewController.sheetPresentationController {
                sheet.preferredCornerRadius = 40
                sheet.prefersGrabberVisible = true
                if #available(iOS 16.0, *) {
                    sheet.detents = [
                        .custom { _ in
                            return 360
                        }
                    ]
                } else {
                    sheet.detents = [.medium()]
                }
            }
            self.present(modalViewController, animated: true)
        }
    }
}

extension WelcomeViewController: dismissModalDelegate {
    func dismissModalAndPushViewController() {
        let enterLicenseInfoVc = EnterLicenseInfoViewController()
        self.navigationController?.pushViewController(enterLicenseInfoVc, animated: true)
    }
}
