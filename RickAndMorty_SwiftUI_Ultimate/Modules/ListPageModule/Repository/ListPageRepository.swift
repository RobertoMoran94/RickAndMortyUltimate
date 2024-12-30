//
//  ListPageRepository.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//

import Foundation

protocol ListPageRepository {
    func getCharacterList(page: Int) async throws -> [RawCharacter]?
    
    func searchCharacters(with query: String) async throws -> [RawCharacter]?
    
    func userDidFavorite(character: CharacterModel)
    
    func userDidUnfavorite(character: CharacterModel)
}

class ListPageRepositoryImpl: ListPageRepository {
    @Inject private var service: ServiceAsync
    @Inject private var favoriteLocalStore: FavoriteCharacterLocalData
    
    func getCharacterList(page: Int) async throws ->  [RawCharacter]? {
        guard let url = URL(string: "\(baseURL)character?page=\(page)") else {
            throw ServiceError.badURL
        }
        let result: CharacterListResponse = try await service.fetchData(url: url)
        let favCharacters = getFavoritesCharacter()
        let characters = syncFavCharacter(with: result.results, and: favCharacters)
        return characters
    }
    
    func searchCharacters(with query: String) async throws -> [RawCharacter]? {
        guard let url = URL(string: "\(baseURL)character/?name=\(query)") else {
            throw ServiceError.badURL
        }
        
        let result: CharacterListResponse = try await service.fetchData(url: url)
        let favCharacters = getFavoritesCharacter()
        let characters = syncFavCharacter(with: result.results, and: favCharacters)
        return characters
    }
    
    private func syncFavCharacter(with rawCharacters: [RawCharacter]?, and favCharacters: [CharacterModel]) -> [RawCharacter] {
        guard let rawCharacters else { return [] }
        return rawCharacters.map { rawCharacter -> RawCharacter in
            if let id = rawCharacter.id, favCharacters.contains(where: { $0.id == id }) {
                return RawCharacter(id: rawCharacter.id,
                                    name: rawCharacter.name,
                                    status: rawCharacter.status,
                                    species: rawCharacter.species,
                                    type: rawCharacter.type,
                                    gender: rawCharacter.gender,
                                    origin: rawCharacter.origin,
                                    location: rawCharacter.location,
                                    image: rawCharacter.image,
                                    episode: rawCharacter.episode,
                                    url: rawCharacter.url,
                                    created: rawCharacter.created,
                                    isFavorite: true)
            } else {
                return rawCharacter
            }
        }
    }
    
    func userDidFavorite(character: CharacterModel) {
        favoriteLocalStore.saveFavorite(character: character)
    }
    
    func userDidUnfavorite(character: CharacterModel) {
        favoriteLocalStore.deleteFavorite(character: character)
    }
    
    private func getFavoritesCharacter() -> [CharacterModel] {
        return favoriteLocalStore.fetchFavoriteCharacters().compactMap { favCharacter -> CharacterModel? in
            return favCharacter.toCharacterModel()
        }
    }
}
