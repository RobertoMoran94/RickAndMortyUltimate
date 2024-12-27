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
}

struct RawItemDescription: Decodable {
    let name: String?
    let url: String?
}
