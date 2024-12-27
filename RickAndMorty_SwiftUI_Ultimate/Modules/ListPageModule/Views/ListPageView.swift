//
//  ListPageView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//

import SwiftUI

#Preview {
    ListPageView()
}

struct ListPageView: View {
    @StateObject var viewModel = ListPageViewModel()
    @State var cellDistribution: CellDistribution = .grid
    @State private var searchText = ""
    @State private var onSearchActive: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    SearchBarView(searchText: $searchText) {
                        handleSearchBar()
                    }
                    ListSelectorTypeView(cellDistribution: $cellDistribution)
                }
                characterListScreen()
            }
            .padding(.horizontal)
        }
        .task {
            await viewModel.fetchCharacters()
        }
    }

    @ViewBuilder
    private func characterListScreen() -> some View {
        VStack {
            switch viewModel.viewData {
            case .loading:
                loaderView()
                Spacer()
            case .error:
                Text("Ups...There was an error :(")
                Spacer()
            case let .loaded(viewData):
                Spacer()
                characterListRepresentable(with: viewData)
            }
        }
    }
    
    @ViewBuilder
    private func loaderView() -> some View {
        VStack(alignment: .center) {
            ProgressView()
                .frame(width: 60, height: 60)
                .foregroundStyle(.blue)
        }
    }
    
    @ViewBuilder
    private func characterListRepresentable(with viewData: ListPageViewRepresentable) -> some View {
        ScrollView {
            switch cellDistribution {
            case .grid:
                characterGridView(from: viewData)
            case .list:
                characterListView(from: viewData)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func characterGridView(from viewData: ListPageViewRepresentable) -> some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
            ForEach(viewData.characterList, id: \.id) { character in
                CharacterGridView(characterView: character).onAppear {
                    if viewModel.hasReachedEnd(of: character) {
                        Task {
                            await viewModel.fetchMoreCharacters()
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func characterListView(from viewData: ListPageViewRepresentable) -> some View {
        LazyVStack {
            ForEach(viewData.characterList, id: \.id) { character in
                CharacterListView(characterView: character).onAppear {
                    if viewModel.hasReachedEnd(of: character) {
                        Task {
                            await viewModel.fetchMoreCharacters()
                        }
                    }
                }
            }
        }
    }
    
    private func handleSearchBar() {
        if !searchText.isEmpty {
            onSearchActive = true
            Task {
                await viewModel.searchForCharacters(with: searchText)
            }
        }
        
        if searchText.isEmpty && onSearchActive == true {
            onSearchActive = false
            Task {
                await viewModel.fetchCharacters()
            }
        }
    }
}
