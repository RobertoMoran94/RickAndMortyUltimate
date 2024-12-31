//
//  ProfilePageView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/28/24.
//

import SwiftUI

struct ProfilePageView: View {
    @StateObject var viewModel = ProfilePageViewModel()
    private let characterId: Int?
    
    init(characterId: Int? = nil) {
        self.characterId = characterId
    }

    var body: some View {
        VStack {
            generateScreen()
        }
        .task {
            await viewModel.fetchProfileData(with: self.characterId)
        }
    }
    
    @ViewBuilder
    private func generateScreen() -> some View {
        switch viewModel.viewData {
        case .loading:
            ProgressView()
                .frame(width: 50, height: 50, alignment: .center)
        case .error:
            Text("You haven't selected a character yet. Please select one from the HomePage")
        case let .loaded(characterView):
            profileScreen(with: characterView)
        }
    }
    
    @ViewBuilder
    private func profileScreen(with character: CharacterModel) -> some View {
        VStack(spacing: .large) {
            profileView(with: character)
            
            profileDescription(with: character)
            
            locationDescription(with: character)
            
            Spacer()
        }
        .padding(.standard)
        
    }
    
    @ViewBuilder
    private func profileView(with character: CharacterModel) -> some View {
        VStack(alignment: .center, spacing: 8) {
            CircleProfileView(url: character.image)
                .frame(width: 150, height: 150, alignment: .center)
            
            HStack(alignment: .center, spacing: 8) {
                Text(character.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                CharacterAliveView(model: character)
            }
        }
    }
    
    private func profileDescription(with character: CharacterModel) -> some View {
        HStack(alignment: .center, spacing: .large) {
            
            verticalLabel(title: "Species:", description: character.species)
            
            Divider()
                .frame(height: 50, alignment: .center)
            
            verticalLabel(title: "Type:", description: character.type)
            
            Divider()
                .frame(height: 50, alignment: .center)
            
            verticalLabel(title: "Gender:", description: character.gender)

        }
    }
    
    private func locationDescription(with character: CharacterModel) -> some View {
        VStack {
            horizontalLabel(title: "Origin:", description: character.originName)
            
            horizontalLabel(title: "Location:", description: character.locationName)
        }
    }
    
    private func horizontalLabel(title: String, description: String) -> some View {
        HStack(alignment: .center, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .frame(alignment: .leading)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.primary)
                .frame(alignment: .leading)
        }
    }
    
    private func verticalLabel(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(description)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    ProfilePageView(characterId: 0)
}
