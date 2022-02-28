//
//  UIImage+Extension.swift
//  CreateAppScreenshot
//
//  Created by Peter Pan on 2022/2/27.
//

import UIKit

extension UIImage {
    static func getBundleResourceImage(name: String, directory: Directory, scale: Double) -> UIImage? {
        guard let url = Bundle.main.url(forResource: name, withExtension: nil, subdirectory: directory.rawValue),
              let data = try? Data(contentsOf: url) else {
                  return nil
              }
        return UIImage(data: data, scale: scale)
    }
}
