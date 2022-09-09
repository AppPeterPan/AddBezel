//
//  DeviceRow.swift
//  CreateAppScreenshot
//
//  Created by Peter Pan on 2022/2/28.
//

import SwiftUI

struct DeviceRow: View {
    let device: Device
    var pasteboardImageData: Data?
    var source: Source
    @AppStorage("recentlyUsedDevceId") var recentlyUsedDevceId: String?

    var body: some View {
        Button {
            recentlyUsedDevceId = device.id
            createSnapshots()
        } label: {
            let name = device.imageName.replacingOccurrences(of: ".png", with: "")
            if recentlyUsedDevceId == device.id {
                VStack(alignment: .leading) {
                    Text(name)
                    Text("recently used")
                }
                .font(.title)
                .foregroundColor(.orange)
            } else {
                Text(name)

            }
        
        }
    }
    
    @MainActor func createSnapshots() {
        var snapshotImages = [UIImage]()
        // iPhone 11 之後的機種都是 3x, 只有 iPhone 11 是 2x
        // 較新的 iPad 都是 2x
        var scale = device.imageName.contains("iPhone") ? 3.0 : 2.0
        if device.imageName.contains("iPhone 11 -") {
            scale = 2.0
        }
        guard let deviceImage = UIImage.getBundleResourceImage(name: device.imageName, directory: .device, scale: scale) else { return }
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
            let snapshotView = SnapshotView(screenshotImage: screenshotImage, deviceImage: deviceImage)
            let snapshotImage: UIImage
            if #available(iOS 16.0, *) {
                let render = ImageRenderer(content: snapshotView)
                render.scale = scale
                snapshotImage = render.uiImage ?? UIImage()
            } else {
                snapshotImage = snapshotView.snapshotImage(scale: scale)
            }
            snapshotImages.append(snapshotImage)
            let snapshotImageUrl = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
            try? snapshotImage.pngData()?.write(to: snapshotImageUrl)
        }
        print(FileManager.default.temporaryDirectory)
        UIPasteboard.general.url = FileManager.default.temporaryDirectory
    }
}

struct DeviceRow_Previews: PreviewProvider {
    
    static var previews: some View {
        DeviceRow(device: Device(imageName: "iPhone 13 - Starlight.png", name: .iPhone13, orientation: .portrait), pasteboardImageData: nil, source: .project)
    }
}
