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
    private var searchingWorkItem: DispatchWorkItem?
    private var dispatchGroup: DispatchGroup?
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
    
    // MARK: - Search after user finished typing with Task
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
    
    // MARK: - Search after user finished typing with DispatchWorkItem.
    func searchForCharactersV2(with query: String) async {
        searchingWorkItem?.cancel()
        viewData = .loading
        currentCharacters = []
        
        let workItem = DispatchWorkItem { [weak self] in
            Task {
                do {
                    let result = try await self?.repository.searchCharacters(with: query)
                    let characterListModel = self?.viewData(from: result)
                    guard let model = characterListModel, model.isEmpty else {
                        self?.viewData = .error
                        return
                    }
                    self?.currentCharacters.append(contentsOf: model)
                    guard let characters = self?.currentCharacters else {
                        self?.viewData = .error
                        return
                    }
                    let viewModel = ListPageViewRepresentable(characterList: characters)
                    self?.viewData = .loaded(viewModel)
                } catch {
                    self?.viewData = .error
                }
            }
        }
        searchingWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            workItem.perform()
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
