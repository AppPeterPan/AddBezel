//
//  Orientation.swift
//  CreateAppScreenshot
//
//  Created by Peter Pan on 2022/2/28.
//

import Foundation

enum Orientation: String, CaseIterable, Identifiable {
    case portrait
    case landscape
    
    var id: Self { self }
}
