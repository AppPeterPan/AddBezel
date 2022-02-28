//
//  Source.swift
//  CreateAppScreenshot
//
//  Created by Peter Pan on 2022/2/28.
//

import Foundation

enum Source: String, CaseIterable, Identifiable {
    case pasteboard
    case project

    var id: Self { self }
}
