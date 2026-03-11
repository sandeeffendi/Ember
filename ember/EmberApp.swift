//
//  emberApp.swift
//  ember
//
//  Created by Sande Effendi on 11/03/26.
//


    // BurnoutCheckApp.swift
    import SwiftUI

    @main
    struct EmberApp: App {
        @StateObject private var appViewModel = AppViewModel()

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(appViewModel)
            }
        }
    }
