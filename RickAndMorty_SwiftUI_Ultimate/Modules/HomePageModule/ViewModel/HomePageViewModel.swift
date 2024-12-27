//
//  HomePageViewModel.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/27/24.
//

import Foundation
import Combine

class HomePageViewModel: ObservableObject {
    @Published var viewData: ViewStateData<CharacterModel> = .loading
    private var cancellables: Set<AnyCancellable> = []
    @Inject private var repository: HomePageRepository
    
    func fetchRandomCharacter() {
        repository.fetchRandomCharacter().sink { completion in
            switch completion {
            case .finished:
                print("Random Character fetched!")
            case let .failure(error):
                self.viewData = .error
                print("Error fetching Random Character: \(error.localizedDescription)")
            }
        } receiveValue: { [weak self] character in
            self?.handleFetchedCharacter(with: character)
        }
        .store(in: &cancellables)
    }
    
    private func handleFetchedCharacter(with data: RawCharacter) {
        guard let id = data.id, let name = data.name, let status = data.status, let species = data.species, let origin = data.origin?.name, let location = data.location?.name, let url = data.image, let image =  URL(string: url) else {
            viewData = .error
            return
        }
        let character = CharacterModel(id: id,
                                       name: name,
                                       status: status,
                                       species: species,
                                       originName: origin,
                                       locationName: location,
                                       image: image)
        viewData = .loaded(character)
    }
}
