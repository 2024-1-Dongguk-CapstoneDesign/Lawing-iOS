//
//  LoginMainViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

import LocalAuthentication

final class LoginMainViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = LoginMainView()
    private let authContext = LAContext()
    
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
        
        authContext.localizedFallbackTitle = ""
        authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "인증이 필요합니다.") { (success, error) in
            DispatchQueue.main.async {
                if success {
                    print("인증에 성공했습니다.")
                    //킥보드 이용 뷰컨 푸시
                } else if error != nil {
                    self.navigationController?.pushViewController(LoginRetryViewController(), animated: true)
                }
            }
        }
    }
    
    private func kakaoButtonTapped() {
        print("kakaoButtonTapped")
    }
}
