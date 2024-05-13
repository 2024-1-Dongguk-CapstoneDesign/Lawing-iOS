//
//  LoginRetryViewController.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 5/14/24.
//

import UIKit

final class LoginRetryViewController: UIViewController {
    
    //MARK: - Properties
    
    private let rootView = LoginRetryView()
    
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

extension LoginRetryViewController {
    
    // MARK: - Private Method
    
    private func setTarget() {
        rootView.setupKakaoButton(action: kakaoButtonTapped)
        rootView.setupretryFaceIDButton(action: retryFaceIDButtonTapped)
    }
    
    private func kakaoButtonTapped() {
        print("kakaoButtonTapped")
    }
    
    private func retryFaceIDButtonTapped() {
        print("retryFaceIDButtonTapped")
    }
}
