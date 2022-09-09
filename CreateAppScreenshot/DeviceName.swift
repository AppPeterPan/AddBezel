//
//  DeviceName.swift
//  CreateAppScreenshot
//
//  Created by Peter Pan on 2022/2/28.
//

import Foundation

enum DeviceName: String {
    case iPhone14 = "iPhone 14"
    case iPhone14Plus = "iPhone 14 Plus"
    case iPhone14Pro = "iPhone 14 Pro"
    case iPhone14ProMax = "iPhone 14 Pro Max"
    case iPhone13 = "iPhone 13"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    case iPhone13Mini = "iPhone 13 mini"
    case iPhone12 = "iPhone 12"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Pro Max"
    case iPhone12Mini = "iPhone 12 mini"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhone11 = "iPhone 11"
    case iPad
    case iPadAir = "iPad Air"
    case iPadMini = "iPad mini"
    case iPadPro11 = "iPad Pro 11"
    case iPadPro12 = "iPad Pro 12.9"
    
    static func getDeviceNamesFromWidthPoint(_ width: Double) -> [DeviceName] {
        switch width {
        case 393:
            return [.iPhone14Pro]
        case 430:
            return [.iPhone14ProMax]
        case 428:
            return [.iPhone14Plus, .iPhone13ProMax, .iPhone12ProMax]
        case 390:
            return [.iPhone14, .iPhone13, .iPhone13Pro, .iPhone12, .iPhone12Pro]
        case 375:
            return [.iPhone13Mini, .iPhone12Mini, .iPhone11Pro]
        case 414:
            return [.iPhone11ProMax, .iPhone11]
        case 820:
            return [.iPadAir]
        case 810:
            return [.iPad]
        case 744:
            return [.iPadMini]
        case 834:
            return [.iPadPro11]
        case 1024:
            return [.iPadPro12]
        default:
            return []
        }
    }
}
