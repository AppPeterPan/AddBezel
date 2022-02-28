//
//  SnapshotView.swift
//  CreateAppScreenshot
//
//  Created by Peter Pan on 2022/2/27.
//

import SwiftUI

struct SnapshotView: View {
    let screenshotImage: UIImage
    let deviceImage: UIImage
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(uiImage: screenshotImage)
            Image(uiImage: deviceImage)
        }
        .ignoresSafeArea()
    }
}
