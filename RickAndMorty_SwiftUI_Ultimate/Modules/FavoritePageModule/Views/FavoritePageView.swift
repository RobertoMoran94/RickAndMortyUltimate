//
//  FavoritePageView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/29/24.
//

import SwiftUI

struct FavoritePageView: View {
    @StateObject var viewModel = FavoritePageViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("This are you favorites characters!")
                    .font(.title)
                    .padding()
                
                generateScreen()
                
                Spacer()
            }
        }
        .onAppear {
            viewModel.fetchAllFavoriteCharacters()
        }
    }
    
    @ViewBuilder
    private func generateScreen() -> some View {
        switch viewModel.viewData {
        case .loading:
            ProgressView()
                .frame(width: 50, height: 50, alignment: .center)
        case let .loaded(viewData):
            generateCharacterGrid(with: viewData)
        case .error:
            Text("Ups there was a weird error")
        }
    }
    
    @ViewBuilder
    private func generateCharacterGrid(with characters: [CharacterModel]) -> some View {
        if characters.isEmpty {
            Text("You haven't selected any favorites chracters yet")
        } else {
            LazyVStack {
                ForEach(characters, id: \.id) { character in
                    CharacterRowView(characterView: character,
                                     deleteAction: nil,
                                     didSelectedFavoriteAction: nil)
                }
            }
        }
    }
}

#Preview {
    FavoritePageView()
}
