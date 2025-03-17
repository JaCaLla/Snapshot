//
//  SnapshotTests.swift
//  SnapshotTests
//
//  Created by Javier Calatrava on 17/3/25.
//

import SwiftUI
import SnapshotTesting
import Testing
@testable import Snapshot

protocol TestDevice {
    func viewImageConfig() -> ViewImageConfig
}

struct iPhoneSe: TestDevice  {
     func viewImageConfig() -> ViewImageConfig {
        ViewImageConfig.iPhoneSe
    }
}

struct iPhone13ProMax: TestDevice  {
     func viewImageConfig() -> ViewImageConfig {
        ViewImageConfig.iPhone13ProMax(.portrait)
    }
}

struct iPhone12Landscape: TestDevice  {
     func viewImageConfig() -> ViewImageConfig {
         ViewImageConfig.iPhone12(.landscape)
    }
}


@MainActor
@Suite("Snapshot tests")
struct SnapshotTests {
    
    var record = false // SNAPSHOT TESTING MODE!
    static let devices: [TestDevice] = [iPhoneSe(), iPhone13ProMax(), iPhone12Landscape()]
    
    @Test(arguments: devices) func testFirstView(device: TestDevice) {
        let rootView = RootView()
        let hostingController = UIHostingController(rootView: rootView)
        var named = String(describing: type(of: device))
        assertSnapshot(of: hostingController,
                       as: .image(on: device.viewImageConfig()),
                       named: named,
                       record: record)
    }
    
    @Test(arguments: devices) func testSecondView(device: TestDevice) {
        let secondView = SecondView(navigationPath: .constant(NavigationPath()))
        let hostingController = UIHostingController(rootView: secondView)

        var named = String(describing: type(of: device))
        
        assertSnapshot(of: hostingController,
                       as: .image(on: device.viewImageConfig()),
                       named: named,
                       record: record)
    }
    
    @Test(arguments: devices) func testThirdView(device: TestDevice) {
        let thirdView = ThirdView(navigationPath: .constant(NavigationPath()))
        let hostingController = UIHostingController(rootView: thirdView)

        var named = String(describing: type(of: device))
        
        assertSnapshot(of: hostingController,
                       as: .image(on: device.viewImageConfig()),
                       named: named,
                       record: record)
    }
}
