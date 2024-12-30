//
//  Character.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//

import Foundation

struct CharacterListResponse: Decodable {
    let info: InfoResponse?
    let results: [RawCharacter]?
}

struct InfoResponse: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

struct RawCharacter: Decodable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: RawItemDescription?
    let location: RawItemDescription?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    let isFavorite: Bool?
}

extension RawCharacter {
    func toCharacterModel() -> CharacterModel? {
        guard let id = self.id, let name = self.name, let status = self.status, let species = self.species, let origin = self.origin?.name, let location = self.location?.name, let url = self.image, let image =  URL(string: url), let gender = self.gender, let type = self.type else {
            return nil
        }
        return CharacterModel(id: id,
                              name: name,
                              status: status,
                              species: species,
                              originName: origin,
                              locationName: location,
                              type: type,
                              gender: gender,
                              url: url,
                              isFavorite: self.isFavorite ?? false,
                              image: image)
    }
}

struct RawItemDescription: Decodable {
    let name: String?
    let url: String?
}
