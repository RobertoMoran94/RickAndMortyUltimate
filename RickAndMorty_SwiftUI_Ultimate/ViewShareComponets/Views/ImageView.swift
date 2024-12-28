//
//  ImageView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/27/24.
//

import SwiftUI

struct ImageView: View {
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } else if phase.error != nil {
                ImagePlaceHolderView(modelType: .error)
            } else {
                Rectangle()
                    .fill(Color.secondary)
                    .shimmer()
            }
        }
    }
}

#Preview {
    ImageView(url: URL(string: "")!)
}
