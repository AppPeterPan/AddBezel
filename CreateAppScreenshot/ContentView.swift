
import SwiftUI
import Algorithms
import UniformTypeIdentifiers

struct ContentView: View {
    @State private var orientation = Orientation.portrait
    @State private var source = Source.pasteboard
    @State private var pasteboardImageData: Data?
    @AppStorage("recentlyUsedDevceId") var recentlyUsedDevceId: String?
    @Environment(\.scenePhase) var scenePhase
    var devices: [Device]
    
    init() {
        let directory = Bundle.main.resourcePath! + "/\(Directory.device.rawValue)"
        devices = (try? FileManager.default.contentsOfDirectory(atPath: directory).map {
            let array = $0.components(separatedBy: " - ")
            let name = array[0]
            let orientation: Orientation
            if array.count > 2 {
                let orientationString = array[2].replacingOccurrences(of: ".png", with: "").lowercased()
                orientation = Orientation(rawValue: orientationString) ?? .portrait
            } else {
                orientation = .portrait
            }
            return Device(imageName: $0, name: DeviceName(rawValue: name)!, orientation: orientation)
        }) ?? []
    }
    
    var body: some View {
        NavigationView {
            VStack {
                CustomPicker(selectData: $source, array: Source.allCases)
                   
                CustomPicker(selectData: $orientation, array: Orientation.allCases)
                                
                List {
                    ForEach(filterDevices) { device in
                        DeviceRow(device: device, pasteboardImageData: pasteboardImageData, source: source)
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("add bezel")
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    pasteboardImageData = UIPasteboard.general.data(forPasteboardType: UTType.png.identifier)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    var filterDevices: [Device] {
        switch source {
        case .pasteboard:
            guard let data = pasteboardImageData,
                  let image = UIImage(data: data, scale: UIScreen.main.scale) else { return [] }
            let deviceNames = DeviceName.getDeviceNamesFromWidthPoint(image.size.width)
            return devices.filter {
                deviceNames.contains($0.name) && $0.orientation == orientation
            }.sorted(by: sortDevices(device1:device2:))
    
        case .project:
            let directory = Bundle.main.resourcePath! + "/\(Directory.screenshot.rawValue)"
            let screenshots: [String] = (try? FileManager.default.contentsOfDirectory(atPath: directory)) ?? []
            let targetDeviceName = screenshots.first?.components(separatedBy: " - ")[1].components(separatedBy: " (").first ?? ""
            let targetDevice = DeviceName(rawValue: targetDeviceName)

            return devices.filter {
                $0.name == targetDevice && $0.orientation == orientation
            }.sorted(by: sortDevices(device1:device2:))
        }
    }
    
    func sortDevices(device1: Device, device2: Device) -> Bool {
        if recentlyUsedDevceId == device1.id {
            return true
        } else if recentlyUsedDevceId == device2.id {
            return false
        } else {
            return device1.name.rawValue > device2.name.rawValue
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomPicker<T: Hashable>: View where T: Identifiable, T: RawRepresentable, T.RawValue: StringProtocol {
    @Binding var selectData: T
    let array: [T]

    var body: some View {
        Picker("", selection: $selectData) {
            ForEach(array) { element in
                Text(element.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
}
