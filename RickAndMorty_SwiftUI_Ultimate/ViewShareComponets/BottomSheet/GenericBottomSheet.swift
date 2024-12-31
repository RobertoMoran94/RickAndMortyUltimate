//
//  GenericBottomSheet.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/30/24.
//

import SwiftUI
import Combine

struct GenericBottomSheet<Content: View>: View {
    let content: () -> Content
    let onSelectCharacter: () -> Void
    let actionSubject: PassthroughSubject<Void, Never>
    
    var body: some View {
        VStack {
            content()
                .padding(.top)
            
            Button {
                actionSubject.send()
            } label: {
                Text("Select this!")
                    .padding(8)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
            }
            
            Spacer()
        }
        .padding(.standard)
        .presentationDetents([.height(dynamicHeight)])
        .presentationDragIndicator(.visible)
    }
    
    private var dynamicHeight: CGFloat {
        UIScreen.screenHeight * 0.65
    }
}

#Preview {
    let subject = PassthroughSubject<Void, Never>()
    
    GenericBottomSheet(content: {
        Text("Any Text")
    }, onSelectCharacter: { }, actionSubject: subject)
}
