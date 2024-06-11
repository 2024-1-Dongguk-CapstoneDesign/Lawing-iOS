//
//  SplashViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 6/10/24.
//

import UIKit

import LocalAuthentication
import KakaoSDKUser

final class SplashViewController: UIViewController {
    
    //MARK: - Properties
    
    private let authContext = LAContext()
    
    //MARK: - UI Properties
    
    private let logoImageView = UIImageView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupHierarchy()
        setupLayout()
        
        checkKakaoLoginStatus { isLoggedIn in
            if isLoggedIn {
                self.authenticateWithFaceID()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.showLoginView()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = false
    }
}

extension SplashViewController {
    
    // MARK: - Private Method
    
    private func setupStyle() {
        view.backgroundColor = .lawingWhite
        
        logoImageView.do {
            $0.image = .lawingLogo
        }
    }
    
    private func setupHierarchy() {
        view.addSubview(logoImageView)
    }
    
    private func setupLayout() {
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func checkKakaoLoginStatus(completion: @escaping (Bool) -> Void) {
        UserApi.shared.me { user, error in
            if let _ = user {
                // 로그인 상태
                completion(true)
            } else {
                // 로그아웃 상태
                completion(false)
            }
        }
    }
    
    private func authenticateWithFaceID() {
        authContext.localizedFallbackTitle = ""
        authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "인증이 필요합니다.") { (success, error) in
            DispatchQueue.main.async {
                if success {
                    print("인증에 성공했습니다.")
                    
                    let mainVC = MainViewController()
                    self.navigationController?.pushViewController(mainVC, animated: true)
                } else if error != nil {
                    self.navigationController?.pushViewController(LoginRetryViewController(), animated: true)
                }
            }
        }
    }
    
    private func showLoginView() {
        let loginMainVC = LoginMainViewController()
        self.navigationController?.pushViewController(loginMainVC, animated: false)
    }
}
