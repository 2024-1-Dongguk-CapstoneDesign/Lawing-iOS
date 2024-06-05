//
//  MemberAPIService.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 6/5/24.
//

import Foundation

import Moya

final class MemberAPIService: BaseService {
    static let shared = MemberAPIService()
    private var memberProvider = MoyaProvider<BaseTargetType>(plugins: [MoyaPlugin()])
    private override init() {}
}

extension MemberAPIService {
    func postMemberSocialLogin(kakaoAccessToken: String, request: LoginTypeRequestDTO, completion: @escaping (NetworkResult<MemberTokenResponseDTO>) -> Void) {
        memberProvider.request(.postMemberSocialLogin(kakaoAccessToken: kakaoAccessToken, request: request)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<MemberTokenResponseDTO> = self.fetchNetworkResult(
                    statusCode: response.statusCode,
                    data: response.data
                )
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
}
