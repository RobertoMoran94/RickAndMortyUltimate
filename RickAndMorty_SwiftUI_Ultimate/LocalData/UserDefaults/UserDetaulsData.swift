//
//  UserDefautsData.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/27/24.
//

import Foundation

protocol UserDefaultsData {
    func saveUserCharacterSelection(from character: CharacterModel) -> Bool
    
    func fetchCharacterSelection() -> CharacterModel?
    
    func deleteSelectedCharacter() -> Bool
}

class UserDefaultsDataImpl: UserDefaultsData {
    let userDefaults = UserDefaults.standard
    let userCharacterKey = "SELECTED_CHARACTER"
    let encoder = JSONEncoder()
    let decoded = JSONDecoder()
    
    func saveUserCharacterSelection(from character: CharacterModel) -> Bool {
        if let encodedData = try? encoder.encode(character) {
            userDefaults.set(encodedData, forKey: userCharacterKey)
            return true
        } else {
            print("Failed to encode character.")
            return false
        }
        
    }
    
    func fetchCharacterSelection() -> CharacterModel? {
        guard let savedData = userDefaults.data(forKey: userCharacterKey) else {
            print("There is no character found in UserDefaults")
            return nil
        }
        guard let decodedCharacter = try? decoded.decode(CharacterModel.self, from: savedData) else {
            print("There was a problem decoding character founded in UserDefaults")
            return nil
        }
        return decodedCharacter
    }
    
    func deleteSelectedCharacter() -> Bool {
        userDefaults.removeObject(forKey: userCharacterKey)
        return true
    }
}
