//
//  DeviceRow.swift
//  CreateAppScreenshot
//
//  Created by Peter Pan on 2022/2/28.
//

import SwiftUI

struct DeviceRow: View {
    let deviceImageName: String
    @Binding var pasteboardImageData: Data?
    @Binding var source: Source
    
    var body: some View {
        Button {
            createSnapshots()
        } label: {
            let name = deviceImageName.replacingOccurrences(of: ".png", with: "")
            Text(name)
        }
    }
    
    func createSnapshots() {
        var snapshotImages = [UIImage]()
        let scale = deviceImageName.contains("iPhone") ? 3.0 : 2.0
        guard let deviceImage = UIImage.getBundleResourceImage(name: deviceImageName, directory: .device, scale: scale) else { return }
        var screenshotImages = [UIImage]()
        
        if source == .pasteboard {
            if let pasteboardImageData = pasteboardImageData,
               let screenshotImage = UIImage(data: pasteboardImageData, scale: scale) {
                screenshotImages.append(screenshotImage)
            }
        } else {
            let directory = Bundle.main.resourcePath! + "/\(Directory.screenshot.rawValue)"
            let screenshotNames = (try? FileManager.default.contentsOfDirectory(atPath: directory)) ?? []
            for screenshotName in screenshotNames {
                if let screenshotImage = UIImage.getBundleResourceImage(name: screenshotName, directory: .screenshot, scale: scale) {
                    screenshotImages.append(screenshotImage)
                }
            }
        }
        screenshotImages.forEach { screenshotImage in
            let snapshotImage = SnapshotView(screenshotImage: screenshotImage, deviceImage: deviceImage).snapshotImage(scale: scale)
            snapshotImages.append(snapshotImage)
            let snapshotImageUrl = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
            try? snapshotImage.pngData()?.write(to: snapshotImageUrl)
        }
        UIPasteboard.general.url = FileManager.default.temporaryDirectory
    }
}

struct DeviceRow_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceRow(deviceImageName: "iPhone 13 - Starlight.png", pasteboardImageData: .constant(nil), source: .constant(.project))
    }
}
