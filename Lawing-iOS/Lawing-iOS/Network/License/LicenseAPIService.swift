//
//  LicenseAPIService.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 6/6/24.
//

import Foundation

import Moya

final class LicenseAPIService: BaseService {
    static let shared = LicenseAPIService()
    private var lisenseProvider = MoyaProvider<BaseTargetType>(plugins: [MoyaPlugin()])
    private override init() {}
}

extension LicenseAPIService {
    func postLisenceValid(request: LisenceValidRequestDTO, completion: @escaping (NetworkResult<LisenceResponseDTO>) -> Void) {
        lisenseProvider.request(.postLisenceValid(request: request)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<LisenceResponseDTO> = self.fetchNetworkResult(
                    statusCode: response.statusCode,
                    data: response.data
                )
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    func postLisenceOCR(imageData: Data, completion: @escaping (NetworkResult<LisenceResponseDTO>) -> Void) {
        lisenseProvider.request(.postLisenceOCR(imageData: imageData)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<LisenceResponseDTO> = self.fetchNetworkResult(
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
