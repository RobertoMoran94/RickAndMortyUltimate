//
//  HomePageView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/26/24.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var viewModel = HomePageViewModel()
    @State var showCharacterSelectedAlert: Bool = false
    
    var body: some View {
        ScrollView {
                if let selectedCharacter = viewModel.viewData.selectedCharacter {
                    CharacterRowView(characterView: selectedCharacter) {
                        withAnimation {
                            viewModel.showAlertWhenDeletingCharacter()
                        }
                    }
                    .frame(maxHeight: 120, alignment: .center)
                }
                
                Text("Get a new Character!")
                
                buildCharacterCard()
                    .frame(maxWidth: UIScreen.screenWidth * 0.95,
                           minHeight: UIScreen.screenHeight * 0.55,
                           alignment: .center)
                
                Spacer()
                
                selectionButtons()
        }
        .padding(.standardPadding)
        .scrollIndicators(.hidden)
        .standardAlertModifier(isPresented: $showCharacterSelectedAlert,
                               model: viewModel.viewData.alertModel)
        .onChange(of: viewModel.screenAlertState) { oldValue, newValue in
            showCharacterSelectedAlert = newValue
        }
        .onAppear {
            viewModel.initialize()
        }
    }
    
    @ViewBuilder
    private func buildCharacterCard() -> some View {
        switch viewModel.viewData.randomCharacter {
        case .loading:
            Rectangle()
                .shimmer()
            
        case let .loaded(character):
            CardCharacterView(character: character)
            
        case .error:
            ImagePlaceHolderView(modelType: .error)
        }
    }
    
    @ViewBuilder
    private func selectionButtons() -> some View {
        HStack(alignment: .center) {
            SelectionButton(
                action: { viewModel.fetchRandomCharacter() },
                model: .clearModel(label: "Get new a Character!", size: .medium)
            )
            
            SelectionButton(
                action: {
                    withAnimation {
                        viewModel.saveSelectedCharacter()
                    }
                },
                model: .positiveModel(label: "I want this character!", size: .medium)
            )
        }
    }
}

#Preview {
    HomePageView()
}
