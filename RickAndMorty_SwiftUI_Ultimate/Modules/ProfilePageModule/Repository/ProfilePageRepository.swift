//
//  ProfilePageRepository.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/28/24.
//

import Foundation

protocol ProfilePageRepository {
    func fetchProfile() -> CharacterModel?
}

class ProfilePageRepositoryImpl: ProfilePageRepository {
    @Inject var localStorage: UserDefaultsData
    
    func fetchProfile() -> CharacterModel? {
        localStorage.fetchCharacterSelection()
    }
}
