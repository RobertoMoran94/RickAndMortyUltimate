//
//  File.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/26/24.
//
import SwiftUI

enum CellDistribution {
    case grid
    case list
}

struct ListSelectorTypeView: View {
    @Binding var cellDistribution: CellDistribution
    
    var body: some View {
        Button {
            withAnimation {
                cellDistribution = cellDistribution == .grid ? .list : .grid
            }
        } label: {
            switch cellDistribution {
            case .grid:
                Image(systemName: "rectangle.grid.1x2")
                    .frame(width: 20, height: 20, alignment: .center)
            case .list:
                Image(systemName: "rectangle.grid.2x2")
                    .frame(width: 20, height: 20, alignment: .center)
            }
        }
    }
}
