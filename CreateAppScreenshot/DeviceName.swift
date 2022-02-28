//
//  DeviceName.swift
//  CreateAppScreenshot
//
//  Created by Peter Pan on 2022/2/28.
//

import Foundation

enum DeviceName: String {
    case iPhone13 = "iPhone 13"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    case iPhone13Mini = "iPhone 13 mini"
    case iPhone12 = "iPhone 12"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Pro Max"
    case iPhone12Mini = "iPhone 12 mini"
    case iPad
    case iPadAir = "iPad Air"
    case iPadMini = "iPad mini"
    case iPadPro11 = "iPad Pro 11"
    case iPadPro12 = "iPad Pro 12.9"
    
    static func getDeviceNamesFromWidthPoint(_ width: Double) -> [DeviceName] {
        switch width {
        case 428:
            return [.iPhone13ProMax, .iPhone12ProMax]
        case 390:
            return [.iPhone13, .iPhone13Pro, .iPhone12, .iPhone12Pro]
        case 375:
            return [.iPhone13Mini, .iPhone12Mini]
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
