//
//  MemberTokenResponseDTO.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 6/5/24.
//

import Foundation

struct MemberTokenResponseDTO: Codable {
    let accessToken: String
    let refreshToken: String
}
