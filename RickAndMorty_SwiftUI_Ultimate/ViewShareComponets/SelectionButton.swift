//
//  SelectionButton.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/26/24.
//

import SwiftUI

extension SelectionButton {
    struct SelectionButtonModel {
        let label: String
        let style: SelectionButton.BackgroundColor
        
        static func neutralModel(label: String) -> Self {
            SelectionButtonModel(label: label, style: .neutral)
        }

        static func positiveModel(label: String) -> Self {
            SelectionButtonModel(label: label, style: .positive)
        }

        static func alertModel(label: String) -> Self {
            SelectionButtonModel(label: label, style: .alert)
        }

        static func clearModel(label: String) -> Self {
            SelectionButtonModel(label: label, style: .clear)
        }

    }
    
    enum BackgroundColor {
        case neutral
        case positive
        case alert
        case clear
        
        var backgroundColor: Color {
            switch self {
            case .neutral:
                return Color(hex: "#e9ecef")
            case .positive:
                return Color(hex: "#55a630")
            case .alert:
                return Color(hex: "#e76f51")
            case .clear:
                return Color(hex: "e9ecef")
            }
        }
        
        var fontColor: Color {
            switch self {
            case .neutral:
                return .white
            case .positive:
                return .white
            case .alert:
                return .white
            case .clear:
                return .blue
            }
        }
    }
}

struct SelectionButton: View {
    let action: () -> Void
    let model: SelectionButtonModel
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center) {
                Text(model.label)
                    .font(.subheadline)
                    .foregroundStyle(model.style.fontColor)
                    .padding()
                    .background(model.style.backgroundColor)
                    .cornerRadius(12)
            }
        }
    }
}

#Preview {
    SelectionButton(action: {}, model: .neutralModel(label: "Button"))
}
