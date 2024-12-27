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
}

class ListPageRepositoryImpl: ListPageRepository {
    @Inject private var service: ServiceAsync
    
    func getCharacterList(page: Int) async throws ->  [RawCharacter]? {
        guard let url = URL(string: "\(baseURL)character?page=\(page)") else {
            throw ServiceError.badURL
        }
        let result: CharacterListResponse = try await service.fetchData(url: url)
        
        let characters = result.results
        return characters
    }
    
    func searchCharacters(with query: String) async throws -> [RawCharacter]? {
        guard let url = URL(string: "\(baseURL)character/?name=\(query)") else {
            throw ServiceError.badURL
        }
        
        let result: CharacterListResponse = try await service.fetchData(url: url)
        
        let characters = result.results
        return characters
    }
}
