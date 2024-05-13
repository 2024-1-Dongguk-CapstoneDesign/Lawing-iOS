//
//  LoginMainViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

final class LoginMainViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = LoginMainView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        setTarget()
    }
}

extension LoginMainViewController {
    
    // MARK: - Private Method
    
    private func setTarget() {
        rootView.setupLoginButton(action: loginButtonTapped)
        rootView.setupKakaoButton(action: kakaoButtonTapped)
    }
    
    private func loginButtonTapped() {
        print("loginButtonTapped")
    }
    
    private func kakaoButtonTapped() {
        print("kakaoButtonTapped")
    }
}
