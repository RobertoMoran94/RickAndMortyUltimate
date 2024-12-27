//
//  SearchBarView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/26/24.
//

import Foundation
import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    let handleSearchBar: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search...", text: $searchText)
                .onChange(of: searchText) {
                    handleSearchBar()
                }
            Spacer()
            
            clearSearchBarButton()
        }
        .padding([.top, .bottom], 6)
        .padding(.horizontal, 8)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
    }
    
    @ViewBuilder
    private func clearSearchBarButton() -> some View {
        Button {
            searchText = ""
        } label: {
            Image(systemName: "xmark.circle.fill")
        }
    }
}
