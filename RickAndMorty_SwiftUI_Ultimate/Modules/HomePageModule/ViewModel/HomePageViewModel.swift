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
    @Published var screenAlertState: Bool = false
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
        } else {
            viewData.selectedCharacter = nil
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
        guard let id = data.id, let name = data.name, let status = data.status, let species = data.species, let origin = data.origin?.name, let location = data.location?.name, let url = data.image, let image =  URL(string: url), let gender = data.gender, let type = data.type else {
            viewData.randomCharacter = .error
            return
        }
        let newCharacter = CharacterModel(id: id,
                                          name: name,
                                          status: status,
                                          species: species,
                                          originName: origin,
                                          locationName: location,
                                          type: type,
                                          gender: gender,
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
        showScreenAlert()
    }
    
    private func updateSelectedCharacterViewData() {
        viewData.alertModel = StandardAlertModifier.Model(title: "You selected a character!",
                                                          message: "Successfully saved",
                                                          okAction: closeScreenAlert,
                                                          cancelAction: nil)
        fetchSelectedCharacterViewData()
    }
    
    private func showAlertErrorWhenSavingCharacter() {
        viewData.alertModel = StandardAlertModifier.Model(title: "You selected a character!",
                                                          message: "There was an error saving the character",
                                                          okAction: closeScreenAlert,
                                                          cancelAction: nil)
    }
    
    func showAlertWhenDeletingCharacter() {
        viewData.alertModel = StandardAlertModifier.Model(title: "You're Deleting your Character!",
                                                          message: "Are you sure you want to delete this character?",
                                                          okAction: deleteSelectedCharacter,
                                                          cancelAction: closeScreenAlert)
        showScreenAlert()
    }
    
    
    private func closeScreenAlert() {
        self.screenAlertState = false
    }
    
    private func deleteSelectedCharacter() {
        if repository.deleteSelectedCharacter() {
            fetchSelectedCharacterViewData()
        }
        closeScreenAlert()
    }
    
    private func showScreenAlert() {
        self.screenAlertState = true
    }
}

