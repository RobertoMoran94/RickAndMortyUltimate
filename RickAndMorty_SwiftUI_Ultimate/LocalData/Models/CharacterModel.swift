//
//  CharacterModel.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/29/24.
//
import Foundation
import SwiftUICore

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let originName: String
    let locationName: String
    let type: String
    let gender: String
    let url: String
    let isFavorite: Bool
    let image: URL
    
    var statusColor: Color {
        if status == "Alive" {
            Color.green
        } else if status == "Dead" {
            Color.red
        } else {
            Color.gray
        }
    }
}

extension FavoriteCharacter {
    func toCharacterModel() -> CharacterModel? {
        guard let stringId = self.id, let id = Int(stringId), let name = self.name, let status = self.status, let species = self.species, let gender = self.gender, let originName = self.originName, let locationName = self.locationName, let type = self.type, let url = self.url, let image = URL(string: url) else { return nil }
        return CharacterModel(id: id,
                              name: name,
                              status: status,
                              species: species,
                              originName: originName,
                              locationName: locationName,
                              type: type,
                              gender: gender,
                              url: url,
                              isFavorite: false,
                              image: image)
    }
}
