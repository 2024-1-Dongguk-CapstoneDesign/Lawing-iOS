//
//  LisenceResponseDTO.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 6/5/24.
//

import Foundation

struct LisenceResponseDTO: Codable {
    let timestamp: String
    let statusCode: Int
    let status: String
    let description: String
    let message: String
}
