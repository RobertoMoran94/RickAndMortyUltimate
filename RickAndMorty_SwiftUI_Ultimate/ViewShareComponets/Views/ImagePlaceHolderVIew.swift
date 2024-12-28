//
//  ImagePlaceHolderVIew.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/27/24.
//

import SwiftUI

extension ImagePlaceHolderView {
    enum PlaceHolderType {
        case error
        case loading
    }
}

struct ImagePlaceHolderView: View {
    let modelType: PlaceHolderType
    
    var body: some View {
        if modelType == .error {
            Image.placeHolderError
                .placeHolderStyle()
        } else {
            Image.placeHolder
                .placeHolderStyle()
        }
    }
}

extension Image {
    func placeHolderStyle() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
    }
}

#Preview {
    ImagePlaceHolderView(modelType: .error)
}
