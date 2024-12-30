//
//  FavoritePageRepository.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/29/24.
//

import Foundation

protocol FavoritePageRepository {
    func fetchFavoriteCharacters() -> [FavoriteCharacter]
}

class FavoritePageRepositoryImpl: FavoritePageRepository {
    @Inject private var localStorage: FavoriteCharacterLocalData
    
    func fetchFavoriteCharacters() -> [FavoriteCharacter] {
        return localStorage.fetchFavoriteCharacters()
    }
}
