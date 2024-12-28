//
//  CharacterListView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//
import SwiftUI

struct CharacterRowView: View {
    let characterView: CharacterModel
    let deleteAction: (() -> Void)?
    
    init(characterView: CharacterModel, deleteAction: (() -> Void)? = nil) {
        self.characterView = characterView
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        HStack(alignment: .center) {
            CircleProfileView(url: characterView.image)
                .frame(width: 80, height: 80, alignment: .center)
            
            ProfileDescriptionView(name: characterView.name,
                                   statusColor: characterView.statusColor,
                                   specie: characterView.species,
                                   originName: characterView.originName
            )
            .padding(.leading)
            
            Spacer()
            
            if let action = deleteAction {
                Button {
                    action()
                } label: {
                    Text("Delete")
                        .font(.caption)
                        .bold()
                        .padding(8)
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical ,8)
        .padding(.horizontal ,12)
        .background(Color.blue.opacity(0.6))
        .cornerRadius(6)
    }
}
