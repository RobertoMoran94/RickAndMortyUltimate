//
//  HomePageRepository.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/27/24.
//

import Foundation
import Combine

protocol HomePageRepository {
    func fetchRandomCharacter() -> AnyPublisher<RawCharacter, ServiceError>
    
    func saveCharacter(character: CharacterModel) -> Bool
    
    func fetchSelectedCharacter() -> CharacterModel?
    
    func deleteSelectedCharacter() -> Bool
}

class HomePageRepositoryImpl: HomePageRepository {
    @Inject private var service: CombineService
    @Inject private var localData: UserDefaultsData
    
    func fetchRandomCharacter() -> AnyPublisher<RawCharacter, ServiceError> {
        let url = getRandomCharacterURL()
        return service.fetchData(url: url)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func getRandomCharacterURL() -> URL? {
        let randomCharacter = Int.random(in: 0...800)
        let url = baseURL.appending("character/\(randomCharacter)")
        guard let newURL = URL(string: url) else { return nil }
        return newURL
    }
    
    func saveCharacter(character: CharacterModel) -> Bool {
        return localData.saveUserCharacterSelection(from: character)
    }
    
    func fetchSelectedCharacter() -> CharacterModel? {
        return localData.fetchCharacterSelection()
    }
    
    func deleteSelectedCharacter() -> Bool {
        return localData.deleteSelectedCharacter()
    }
}
