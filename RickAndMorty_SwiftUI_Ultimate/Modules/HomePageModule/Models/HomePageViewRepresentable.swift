//
//  HomePageViewRepresentable.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/28/24.
//

struct HomePageViewRepresentable {
    var selectedCharacter: CharacterModel?
    var randomCharacter: ViewStateData<CharacterModel> = .loading
    var alertModel: StandardAlertModifier.Model = .defaultModel
    
    static func initializationValues() -> HomePageViewRepresentable {
        HomePageViewRepresentable(selectedCharacter: nil)
    }
}
