//
//  Device.swift
//  CreateAppScreenshot
//
//  Created by Peter Pan on 2022/2/28.
//

import Foundation

struct Device: Identifiable {
    let imageName: String
    let name: DeviceName
    let orientation: Orientation
    var id: String { imageName }
    
   
}

