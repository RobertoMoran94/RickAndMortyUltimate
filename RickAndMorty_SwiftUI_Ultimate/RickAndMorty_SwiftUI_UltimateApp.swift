//
//  RickAndMorty_SwiftUI_UltimateApp.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/15/24.
//

import SwiftUI

@main
struct RickAndMorty_SwiftUI_UltimateApp: App {
    init() {
        InjectRoot.attach(rootContainer: AppRootContainer.shared)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: ScenePhase.active) { phase in
            switch phase {
            case .background:
                print("RickAndMortyApp: Goes to background")
            case .inactive:
                print("RickAndMortyApp: Goes to Inactive")
            case .active:
                print("RickAndMortyApp: Goes to Active")
            @unknown default:
                print("RickAndMortyApp: Goes to Default")
            }
        }
    }
}
