//
//  ImageUtils.swift
//  Millie
//
//  Created by DK on 5/23/24.
//

import Foundation
import SwiftUI

class ImageUtils {

     static let shared = ImageUtils()

     private init() {}
    
    @MainActor
    func saveCacheImage(url: String, image: Image) {
        guard !url.isEmpty else { return }
        let fileManager = FileManager.default
        if let fileName = url.split(separator: "/").last,
           let savePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(String(fileName)) {
            let exists = fileManager.fileExists(atPath: savePath.path())
            if !exists {
                let renderer = ImageRenderer(content: image)
                if let uiImage = renderer.uiImage {
                    if let data = uiImage.jpegData(compressionQuality: 0.8) {
                        try? data.write(to: savePath)
                        print("Image saved to: \(savePath.absoluteString)")
                    }
                }
            }
        }
     }
    
    func getChcheImage(url: String) -> URL? {
        let fileManager = FileManager.default
        if let fileName = url.split(separator: "/").last,
           let savePath = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(String(fileName)) {
            let exists = fileManager.fileExists(atPath: savePath.path())
            if exists {
                return savePath
            }
        }
        return nil
    }

    
}
