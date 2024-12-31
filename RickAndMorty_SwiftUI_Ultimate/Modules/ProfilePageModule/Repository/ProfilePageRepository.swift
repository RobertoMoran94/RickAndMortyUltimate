//
//  ProfilePageRepository.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/28/24.
//

import Foundation

protocol ProfilePageRepository {
    func fetchProfile(characterId: Int?)  async -> CharacterModel?
}

class ProfilePageRepositoryImpl: ProfilePageRepository {
    @Inject var localStorage: UserDefaultsData
    @Inject var service: ServiceAsync
    private let endPoint = "character/"
    
    func fetchProfile(characterId: Int?) async -> CharacterModel? {
        if let id = characterId, let url = URL(string: "\(baseURL)\(endPoint)\(String(id))") {
            do {
                let rawCharacter = try await fetchServiceProfile(with: id, and: url)
                return rawCharacter.toCharacterModel()
            } catch {
                return localStorage.fetchCharacterSelection()
            }
        } else {
            return localStorage.fetchCharacterSelection()
        }
    }
    
    private func fetchServiceProfile(with id: Int, and url: URL) async throws -> RawCharacter {
        do {
            return try await service.fetchData(url: url)
        } catch {
            throw ServiceError.networkError
        }
    }
}
