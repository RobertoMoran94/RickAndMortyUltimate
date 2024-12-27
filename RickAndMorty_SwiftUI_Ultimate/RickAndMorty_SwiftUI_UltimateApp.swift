//
//  RickAndMorty_SwiftUI_UltimateApp.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/15/24.
//

import SwiftUI

@main
struct RickAndMorty_SwiftUI_UltimateApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        InjectRoot.attach(rootContainer: AppRootContainer.shared)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
