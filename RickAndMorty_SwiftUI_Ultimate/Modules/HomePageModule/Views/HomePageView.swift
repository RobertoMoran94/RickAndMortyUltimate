//
//  HomePageView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/26/24.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var viewModel = HomePageViewModel()
    @State var showSelectedCharacterButton: Bool = false
    
    var body: some View {
        VStack {
            Text("Get a Character!")
            
            buildCharacterCard()
            
            Spacer()
            
            selectionButtons()
        }
        .padding(.bottom, 18)
    }
    
    @ViewBuilder
    private func buildCharacterCard() -> some View {
        switch viewModel.viewData {
        case .loading:
            ImagePlaceHolderView(modelType: .loading)
                .onAppear {
                    withAnimation {
                        self.showSelectedCharacterButton = true
                    }
                }
        case let .loaded(character):
            CardCharacterView(character: character)
                .onAppear {
                    withAnimation {
                        self.showSelectedCharacterButton = true
                    }
                }
        case .error:
            ImagePlaceHolderView(modelType: .error)
                .onAppear {
                    withAnimation {
                        self.showSelectedCharacterButton = true
                    }
                }
        }
    }
    
    @ViewBuilder
    private func selectionButtons() -> some View {
        HStack {
            SelectionButton(
                action: {
                    viewModel.fetchRandomCharacter()
                },
                model: .clearModel(label: "Get a Character!")
            )
            
            if showSelectedCharacterButton {
                SelectionButton(
                    action: {
                        // TODO: Trigger action.
                    },
                    model: .positiveModel(label: "Select this character!")
                )
            }
        }
    }
}

#Preview {
    HomePageView()
}
