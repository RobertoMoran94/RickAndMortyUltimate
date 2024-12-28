//
//  HomePageViewModel.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/27/24.
//

import Foundation
import Combine

class HomePageViewModel: ObservableObject {
    @Published var viewData: HomePageViewRepresentable = .initializationValues()
    @Published var savedCharacterNotice: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    @Inject private var repository: HomePageRepository
    private var currentCharacter: CharacterModel?
    
    func initialize() {
        fetchSelectedCharacterViewData()
        fetchRandomCharacter()
    }
    
    func fetchSelectedCharacterViewData() {
        if let selectedCharacter = repository.fetchSelectedCharacter() {
            viewData.selectedCharacter = selectedCharacter
        }
    }
    
    func fetchRandomCharacter() {
        viewData.randomCharacter = .loading
        repository.fetchRandomCharacter().sink { completion in
            switch completion {
            case .finished:
                print("Random Character fetched!")
            case let .failure(error):
                self.viewData.randomCharacter = .error
                print("Error fetching Random Character: \(error.localizedDescription)")
            }
        } receiveValue: { [weak self] character in
            self?.handleFetchedCharacter(with: character)
        }
        .store(in: &cancellables)
    }
    
    private func handleFetchedCharacter(with data: RawCharacter) {
        guard let id = data.id, let name = data.name, let status = data.status, let species = data.species, let origin = data.origin?.name, let location = data.location?.name, let url = data.image, let image =  URL(string: url) else {
            viewData.randomCharacter = .error
            return
        }
        let newCharacter = CharacterModel(id: id,
                                          name: name,
                                          status: status,
                                          species: species,
                                          originName: origin,
                                          locationName: location,
                                          image: image)
        currentCharacter = newCharacter
        viewData.randomCharacter = .loaded(newCharacter)
    }
    
    func saveSelectedCharacter() {
        setSelectedCharacterViewData()
    }
    
    private func setSelectedCharacterViewData() {
        guard let currentCharacter else { return }
        let isSaved = repository.saveCharacter(character: currentCharacter)
        if isSaved {
            updateSelectedCharacterViewData()
        } else {
            showAlertErrorWhenSavingCharacter()
        }
        self.savedCharacterNotice = true
    }
    
    private func updateSelectedCharacterViewData() {
        viewData.alertModel = StandardAlertModifier.Model(title: "You selected a character!",
                                                          message: "Successfully saved",
                                                          closeAction: closeSelectedCharacterAlert,
                                                          cancelAction: nil)
        fetchSelectedCharacterViewData()
    }
    
    private func showAlertErrorWhenSavingCharacter() {
        viewData.alertModel = StandardAlertModifier.Model(title: "You selected a character!",
                                                          message: "There was an error saving the character",
                                                          closeAction: closeSelectedCharacterAlert,
                                                          cancelAction: nil)
    }
    
    func closeSelectedCharacterAlert() {
        self.savedCharacterNotice = false
    }
}

struct HomePageViewRepresentable {
    var selectedCharacter: CharacterModel?
    var randomCharacter: ViewStateData<CharacterModel> = .loading
    var alertModel: StandardAlertModifier.Model = .defaultModel
    
    static func initializationValues() -> HomePageViewRepresentable {
        HomePageViewRepresentable(selectedCharacter: nil)
    }
}
