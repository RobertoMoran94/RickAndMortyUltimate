//
//  FavoriteCharacterLocalData.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/29/24.
//

import Foundation
import UIKit
import CoreData

protocol FavoriteCharacterLocalData {
    func fetchFavoriteCharacters() -> [FavoriteCharacter]
    
    func saveFavorite(character: CharacterModel)
    
    func deleteFavorite(character: CharacterModel)
}

class FavoriteCharacterLocalDataImpl: FavoriteCharacterLocalData {
    private var viewContext: NSManagedObjectContext?
    
    init(viewContext: NSManagedObjectContext?) {
        self.viewContext = viewContext
    }
    
    func fetchFavoriteCharacters() -> [FavoriteCharacter] {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        do {
            guard let characters = try viewContext?.fetch(request), !characters.isEmpty else {
                return []
            }
            return characters
        } catch {
            print("Failed to fetch favorite characters: \(error)")
            return []
        }
    }
    
    func saveFavorite(character: CharacterModel) {
        guard let context = viewContext else {
            print("Error: View context is not available")
            return
        }
        print("SaveFavorite Character: \(character)")
        do {
            let newFavorite = FavoriteCharacter(context: context)
            newFavorite.id = String(character.id)
            newFavorite.name = character.name
            newFavorite.status = character.status
            newFavorite.gender = character.gender
            newFavorite.locationName = character.locationName
            newFavorite.originName = character.originName
            newFavorite.type = character.type
            newFavorite.species = character.species
            newFavorite.url = character.url
            try context.save()
            print("Successfully saved favorite character: \(character.name)")
        } catch {
            print("Failed to save favorite character: \(error)")
        }
    }
    
    func deleteFavorite(character: CharacterModel) {
        guard let context = viewContext else {
            print("Error: View context is not available")
            return
        }
        
        do {
            let deletedCharacter = FavoriteCharacter(context: context)
            deletedCharacter.id = String(character.id)
            deletedCharacter.name = character.name
            deletedCharacter.status = character.status
            deletedCharacter.gender = character.gender
            deletedCharacter.locationName = character.locationName
            deletedCharacter.originName = character.originName
            deletedCharacter.type = character.type
            deletedCharacter.species = character.species
            deletedCharacter.url = character.url
            context.delete(deletedCharacter)
            try context.save()
            print("Successfully deleted favorite character")
        } catch {
            print("Failed to delete favorite character: \(error)")
        }
    }
}
