//
//  ProfilePageViewModel.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/28/24.
//

import Foundation

class ProfilePageViewModel: ObservableObject {
    @Inject var repository: ProfilePageRepository
    @Published var viewData: ViewStateData<CharacterModel> = .loading
    
    func fetchProfileData() {
        viewData = .loading
        if let profile = repository.fetchProfile() {
            viewData = .loaded(profile)
            print("MORGAN DEBUG - Profile: \(profile)")
        } else {
            viewData = .error
        }
    }
}
