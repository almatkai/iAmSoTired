//
//  iAmSoTiredApp.swift
//  iAmSoTired
//
//  Created by Almat Kairatov on 03.01.2023.
//

import SwiftUI
import RealmSwift

let theAppConfig = loadAppConfig()

let realmApp = App(id: theAppConfig.appId, configuration: AppConfiguration(baseURL: theAppConfig.baseUrl, transport: nil, localAppName: nil, localAppVersion: nil))

@main
struct iAmSoTiredApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView(app: realmApp)
        }
    }
}
