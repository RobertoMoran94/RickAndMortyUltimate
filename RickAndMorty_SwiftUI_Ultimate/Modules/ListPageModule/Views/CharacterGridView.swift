//
//  CharacterGridView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//
import SwiftUI

struct CharacterGridView: View {
    let characterView: CharacterModel
    
    var body: some View {
        VStack(alignment: .center) {
            CircleProfileView(url: characterView.image)
                .frame(width: 140, height: 140, alignment: .center)
            
            ProfileDescriptionView(name: characterView.name,
                                   statusColor: characterView.statusColor,
                                   specie: characterView.species,
                                   originName: characterView.originName)
            
        }
        .padding()
        .frame(width: .screenWidth() * 0.45, height: .screenHeight()  * 0.32)
        .background(Color.blue.opacity(0.6))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
