//
//  CharacterAliveView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/27/24.
//
import SwiftUI

struct CharacterAliveView: View {
    let model: CharacterModel
    
    var body: some View {
        Text(model.status)
            .font(.caption)
            .bold()
            .padding(12)
            .background(model.statusColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(8)
    }
}
