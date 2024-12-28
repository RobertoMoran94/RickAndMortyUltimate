//
//  CardCharacterView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/27/24.
//
import SwiftUI

struct CardCharacterView: View {
    let character: CharacterModel
    
    var body: some View {
        VStack(alignment: .leading) {
            topImage()
            
            characterInformation()
                .padding(.horizontal, 8)
            
            Spacer()
        }
        .clipShape(Rectangle())
        .overlay(Rectangle().stroke(Color.blue, lineWidth: 3))
        .shadow(radius: 5)
        .cornerRadius(6)
    }
    
    @ViewBuilder
    private func topImage() -> some View {
        ZStack(alignment: .topTrailing) {
            ImageView(url: character.image)
                .clipped()
            
            CharacterAliveView(model: character)
        }
    }
    
    @ViewBuilder
    private func characterInformation() -> some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.headline)
                .lineLimit(1)
                .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Last Location")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(character.locationName)
                    .font(.subheadline)
                    .lineLimit(1)
            }
            .padding(.top, 4)
        }
    }
}
