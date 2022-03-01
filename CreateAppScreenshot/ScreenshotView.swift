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
        ZStack {
            Image(uiImage: screenshotImage)
            Image(uiImage: deviceImage)
        }
        .shadow(radius: 10)
        .ignoresSafeArea()
    }
}


struct SnapshotView_Previews: PreviewProvider {
    static var previews: some View {
        let screenshotImageData = try! Data(contentsOf: Bundle.main.url(forResource: "Simulator Screen Shot - iPhone 13 - 2022-02-28 at 22.26.31.png", withExtension: nil, subdirectory: Directory.screenshot.rawValue)!)
        let screenshotImage = UIImage(data: screenshotImageData, scale: 3)!
        let deviceImageData = try! Data(contentsOf: Bundle.main.url(forResource: "iPhone 13 - Starlight.png", withExtension: nil, subdirectory: Directory.device.rawValue)!)
        let deviceImage = UIImage(data: deviceImageData, scale: 3)!
        return SnapshotView(screenshotImage: screenshotImage, deviceImage: deviceImage)
            .scaleEffect(0.8)
            .previewDevice("iPhone 13")
        
        
    }
}
