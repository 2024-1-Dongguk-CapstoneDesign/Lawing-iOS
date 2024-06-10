//
//  UIImage+.swift
//  Lawing-iOS
//
//  Created by 조혜린 on 6/6/24.
//

import UIKit

extension UIImage {
    func jpegData(compressionQuality: CGFloat, maxSize: Int) -> Data? {
        var compression: CGFloat = compressionQuality
        var imageData = self.jpegData(compressionQuality: compression)

        while let data = imageData, data.count > maxSize, compression > 0 {
            compression -= 0.1
            imageData = self.jpegData(compressionQuality: compression)
        }

        return imageData
    }
}
