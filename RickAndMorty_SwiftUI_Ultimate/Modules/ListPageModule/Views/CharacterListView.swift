//
//  CharacterListView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//
import SwiftUI

struct CharacterListView: View {
    let characterView: CharacterModel
    
    var body: some View {
        HStack(alignment: .center) {
            CircleProfileView(url: characterView.image)
                .frame(width: 80, height: 80, alignment: .center)
            
            ProfileDescriptionView(name: characterView.name,
                                   statusColor: characterView.statusColor,
                                   specie: characterView.species,
                                   originName: characterView.originName
            )
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.vertical ,6)
        .padding(.horizontal ,12)
        .background(Color.blue.opacity(0.6))
        .cornerRadius(8)
    }
}
