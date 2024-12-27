//
//  ContentView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/15/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var viewModel: NavBarViewModel = NavBarViewModel()
    
    var body: some View {
        NavigationView {
            NavBarRootView(viewModel: viewModel)
                .navigationBarTitle("Rick and Morty App", displayMode: .automatic)
                .navigationBarHidden(false)
        }
    }
}

#Preview {
    ContentView()
}
