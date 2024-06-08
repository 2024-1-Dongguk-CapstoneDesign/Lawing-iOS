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
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
}

extension ValidLicenseViewController {
    
    // MARK: - Private Method
    
    
}
