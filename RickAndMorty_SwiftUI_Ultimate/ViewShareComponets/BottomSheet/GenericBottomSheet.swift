//
//  GenericBottomSheet.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/30/24.
//

import SwiftUI

struct GenericBottomSheet<Content: View>: View {
    let content: () -> Content
    let onCloseAction: () -> Void
    
    var body: some View {
        VStack {
            content()
                .padding(.top)
            
            Spacer()
        }
        .padding(.standard)
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    GenericBottomSheet {
        Text("Some Text")
    } onCloseAction: { }
}
