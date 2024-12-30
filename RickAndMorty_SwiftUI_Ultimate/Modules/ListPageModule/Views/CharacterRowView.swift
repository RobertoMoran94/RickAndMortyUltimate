//
//  CharacterListView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//
import SwiftUI

enum CharacterFavoriteAction {
    case favorite
    case unfavorite
}

struct CharacterRowView: View {
    let characterView: CharacterModel
    let deleteAction: (() -> Void)?
    let didSelectedFavoriteAction: ((_ character: CharacterModel, _ actionType: CharacterFavoriteAction) -> Void)?
    @State var isFavorite: Bool = false
    
    init(characterView: CharacterModel,
         deleteAction: (() -> Void)? = nil,
         didSelectedFavoriteAction: ((_ character: CharacterModel, _ actionType: CharacterFavoriteAction) -> Void)? = nil
    ) {
        self.characterView = characterView
        self.deleteAction = deleteAction
        self.didSelectedFavoriteAction = didSelectedFavoriteAction
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
            } else {
                Image(systemName: isFavorite || characterView.isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32, alignment: .center)
                    .foregroundStyle(.red)
                    .padding(.trailing)
                    .onTapGesture {
                        if let action = didSelectedFavoriteAction {
                            let actionType: CharacterFavoriteAction = isFavorite || characterView.isFavorite ? .unfavorite : .favorite
                            action(characterView, actionType)
                        }
                        isFavorite = !(isFavorite || characterView.isFavorite)
                    }
            }
        }
        .padding(.vertical ,8)
        .padding(.horizontal ,12)
        .background(Color.blue.opacity(0.6))
        .cornerRadius(6)
        .onAppear {
            isFavorite = characterView.isFavorite ? true : false
        }
    }
}
