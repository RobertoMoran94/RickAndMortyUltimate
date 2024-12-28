//
//  ListPageViewRepresentable 2.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//
import Foundation
import SwiftUI

struct ListPageViewRepresentable {
    let characterList: [CharacterModel]
}

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let originName: String
    let locationName: String
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
