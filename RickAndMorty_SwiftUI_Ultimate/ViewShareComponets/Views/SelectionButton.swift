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
        let size: SelectionButton.ButtonSize
        
        static func neutralModel(label: String, size: SelectionButton.ButtonSize) -> Self {
            SelectionButtonModel(label: label, style: .neutral, size: size)
        }

        static func positiveModel(label: String, size: SelectionButton.ButtonSize) -> Self {
            SelectionButtonModel(label: label, style: .positive, size: size)
        }

        static func alertModel(label: String, size: SelectionButton.ButtonSize) -> Self {
            SelectionButtonModel(label: label, style: .alert, size: size)
        }

        static func clearModel(label: String, size: SelectionButton.ButtonSize) -> Self {
            SelectionButtonModel(label: label, style: .clear, size: size)
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
    
    enum ButtonSize {
        case small
        case medium
        case large
        
        var width: CGFloat {
            switch self {
            case .small:
                return UIScreen.screenWidth * 0.2
            case .medium:
                return UIScreen.screenWidth * 0.35
            case .large:
                return UIScreen.screenWidth * 0.75
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
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundStyle(model.style.fontColor)
                    .padding()
                    .background(model.style.backgroundColor)
                    .cornerRadius(12)
                    .frame(width: model.size.width, alignment: .center)
            }
        }
    }
}

#Preview {
    SelectionButton(action: {}, model: .neutralModel(label: "Button", size: .medium))
}
