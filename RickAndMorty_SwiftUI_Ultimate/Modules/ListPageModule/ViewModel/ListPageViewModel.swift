//
//  ListPageViewModel.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//
import Foundation

@MainActor
class ListPageViewModel: ObservableObject {
    @Inject private var repository: ListPageRepository
    private var currentPage: Int
    private var currentCharacters: [CharacterModel] = []
    private var searchTask: Task<Void, Never>?
    
    @Published var viewData: ViewStateData<ListPageViewRepresentable> = .loading
    
    init(currentPage: Int = 1) {
        self.currentPage = currentPage
    }
    
    func fetchCharacters() async {
        viewData = .loading
        do {
            let result = try await repository.getCharacterList(page: currentPage)
            let characterListModel = viewData(from: result)
            if characterListModel.isEmpty {
                viewData = .error
                return
            }
            let viewModel = ListPageViewRepresentable(characterList: characterListModel)
            currentCharacters = characterListModel
            viewData = .loaded(viewModel)
        } catch {
            viewData = .error
        }
    }
    
    func fetchMoreCharacters() async {
        currentPage += 1
        do {
            let result = try await repository.getCharacterList(page: currentPage)
            let characterListModel = viewData(from: result)
            if characterListModel.isEmpty {
                viewData = .error
                return
            }
            currentCharacters.append(contentsOf: characterListModel)
            let viewModel = ListPageViewRepresentable(characterList: currentCharacters)
            viewData = .loaded(viewModel)
        } catch {
            print("MORGAN DEBUG: \(error)")
        }
    }
    
    func hasReachedEnd(of character: CharacterModel) -> Bool {
        currentCharacters.last?.id == character.id
    }
    
    func searchForCharacters(with query: String) async {
        viewData = .loading
        currentCharacters = []
        searchTask?.cancel()
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            if Task.isCancelled { return }
            do {
                let result = try await repository.searchCharacters(with: query)
                let characterListModel = viewData(from: result)
                if characterListModel.isEmpty {
                    viewData = .error
                    return
                }
                currentCharacters.append(contentsOf: characterListModel)
                let viewModel = ListPageViewRepresentable(characterList: currentCharacters)
                viewData = .loaded(viewModel)
            } catch {
                viewData = .error
            }
            
        }
    }
    
    private func viewData(from rawData: [RawCharacter]?) -> [CharacterModel] {
        let data = rawData?.compactMap({ (rawCharacter) -> CharacterModel? in
            return rawCharacter.toCharacterModel()
        })
        return data ?? []
    }
    
    func userDidSelected(character: CharacterModel, with actionType: CharacterFavoriteAction) {
        switch actionType {
        case .favorite:
            userDidFavorite(character: character)
        case .unfavorite:
            userDidUnfavorite(character: character)
        }
    }
    
    private func userDidFavorite(character: CharacterModel) {
        repository.userDidFavorite(character: character)
    }
    
    private func userDidUnfavorite(character: CharacterModel) {
        repository.userDidUnfavorite(character: character)
    }
}
