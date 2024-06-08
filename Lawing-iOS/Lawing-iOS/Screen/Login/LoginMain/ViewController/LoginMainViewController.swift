//
//  LoginMainViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

import LocalAuthentication
import KakaoSDKUser

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
        
        setTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.isNavigationBarHidden = true
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
        if (UserApi.isKakaoTalkLoginAvailable()) { // 카카오톡 설치 여부 확인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("토큰 발급 성공!")
                    let myKakaoAccessToken = oauthToken?.accessToken
                    if let myKakaoAccessToken {
                        self.fetchTokenKakaoLogin(kakaoAccenToken: myKakaoAccessToken, socialLoginType: LoginTypeRequestDTO(socialType: "kakao"))
                    }
                }
            }
        }
        else {
            print("카카오톡 미설치")
        }
    }
    
    private func fetchTokenKakaoLogin(kakaoAccenToken: String, socialLoginType: LoginTypeRequestDTO) {
        MemberAPIService.shared.postMemberSocialLogin(kakaoAccessToken: kakaoAccenToken, request: socialLoginType) { response in
            switch response {
            case .success(let data):
                let accessToken = data?.accessToken ?? ""
                UserDefaults.standard.set(accessToken, forKey: "AccessToken")
                
                let welcomeVC = WelcomeViewController()
                self.navigationController?.pushViewController(welcomeVC, animated: true)
            default:
                break
            }
        }
    }
}
