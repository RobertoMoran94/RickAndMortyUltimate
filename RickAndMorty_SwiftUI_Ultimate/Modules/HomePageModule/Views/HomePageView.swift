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
            VStack {
                if let selectedCharacter = viewModel.viewData.selectedCharacter {
                    CharacterRowView(characterView: selectedCharacter)
                        .frame(height: 100, alignment: .center)
                }
                
                Text("Get a new Character!")
                
                buildCharacterCard()
                    .frame(maxWidth: UIScreen.screenWidth * 0.95, minHeight: UIScreen.screenHeight * 0.55, alignment: .center)
                
                Spacer()
                
                selectionButtons()
            }
            .padding(.standardPadding)
        }
        .scrollIndicators(.hidden)
        .alert("You selected a character!", isPresented: $showCharacterSelectedAlert) {
            Button("Close", role: .cancel) {
                viewModel.closeSelectedCharacterAlert()
            }
        } message: {
            Text(viewModel.viewData.alertModel.message)
        }
        .onChange(of: viewModel.savedCharacterNotice) { oldValue, newValue in
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
        HStack(alignment: .center, spacing: 16) {
            Spacer()
            SelectionButton(
                action: { viewModel.fetchRandomCharacter() },
                model: .clearModel(label: "Get new a Character!")
            )
            
            SelectionButton(
                action: { viewModel.saveSelectedCharacter() },
                model: .positiveModel(label: "I want this character!")
            )
            Spacer()
        }
    }
}

#Preview {
    HomePageView()
}
