//
//  TextScannerApp.swift
//  TextScanner
//
//  Created by Ana Paula Sá Barreto Paiva da Cunha on 19/09/24.
//

import SwiftUI

@main
struct TextScannerApp: App {
    @StateObject private var viewmodel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewmodel)
                .task {
                    await viewmodel.requestDataScannerAccessStatus()
                }
        }
    }
}
