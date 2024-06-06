//
//  BaseTargetType.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 6/5/24.
//

import Foundation

import Moya

enum BaseTargetType: TargetType {
    case postLisenceOCR(imageData: Data, imageName: String)
    case postLisenceValid(request: LisenceValidRequestDTO)
    case postMemberSocialLogin(kakaoAccessToken: String, request: LoginTypeRequestDTO)
}

extension BaseTargetType {
    var baseURL: URL {
        guard let urlString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("🚨Base URL을 찾을 수 없습니다🚨")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .postLisenceOCR(_, let imageName):
            return "license/\(imageName)"
        case .postLisenceValid:
            return "license/valid"
        case .postMemberSocialLogin:
            return "member/social/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLisenceOCR, .postLisenceValid, .postMemberSocialLogin:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postLisenceOCR(let imageData, _):
            return .uploadMultipart([MultipartFormData(provider: .data(imageData), name: "image")])
        case .postLisenceValid(let lisenceVaildRequestDTO):
            return .requestJSONEncodable(lisenceVaildRequestDTO)
        case .postMemberSocialLogin(_, let loginTyoeRequestDTO):
            return .requestJSONEncodable(loginTyoeRequestDTO)
            
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .postMemberSocialLogin(let kakaoAccessToken, _):
            return ["Content-Type": "application/json",
                    "kakaoAccessToken": kakaoAccessToken]
        case .postLisenceOCR, .postLisenceValid:
            guard let accessToken = UserDefaults.standard.string(forKey: "AccessToken") else { return [:] }
            return ["Content-Type": "application/json",
                    "Authorization": "Bearer \(accessToken)"]
        }
    }
}
