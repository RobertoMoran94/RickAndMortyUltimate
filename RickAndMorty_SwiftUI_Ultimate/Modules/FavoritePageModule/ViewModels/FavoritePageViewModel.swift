//
//  FavoritePageViewModel.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/29/24.
//

import Foundation

class FavoritePageViewModel: ObservableObject {
    @Published var viewData: ViewStateData<[CharacterModel]> = .loading
    @Inject var repository: FavoritePageRepository
    
    func fetchAllFavoriteCharacters() {
        viewData = .loading
        let favCharacters = repository.fetchFavoriteCharacters()
        let characters = favCharacters.compactMap { favCharacter -> CharacterModel? in
            return favCharacter.toCharacterModel()
        }
        viewData = .loaded(characters)
    }
}
