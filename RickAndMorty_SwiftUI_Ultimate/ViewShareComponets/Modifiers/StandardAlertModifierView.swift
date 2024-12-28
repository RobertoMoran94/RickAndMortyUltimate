//
//  StandardAlertModifierView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/28/24.
//

import SwiftUI

extension View {
    func standardAlertModifier(
        isPresented: Binding<Bool>,
        model: StandardAlertModifier.Model
    ) -> some View {
        self.modifier(StandardAlertModifier(isPresented: isPresented, model: model))
    }
}

struct StandardAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let model: Model
    
    func body(content: Content) -> some View {
        content
            .alert(model.title, isPresented: $isPresented) {
                Button("Ok") {
                    model.okAction()
                }
                if let action = model.cancelAction {
                    Button("Cancel", role: .cancel) {
                        action()
                    }
                }
            } message: {
                Text(model.message)
            }
    }
}

extension StandardAlertModifier {
    struct Model {
        let title: String
        let message: String
        let okAction: () -> Void
        let cancelAction: (() -> Void)?
        
        static var defaultModel: Model {
            .init(title: "Title", message: "Message", okAction: {}, cancelAction: nil)
        }
    }
}
