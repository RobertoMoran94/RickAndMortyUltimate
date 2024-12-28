//
//  CircleProfileView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//

import SwiftUI

struct CircleProfileView: View {
    let url: URL
    
    var body: some View {
        ImageView(url: url)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.green, lineWidth: 2))
            .shadow(radius: 5)
    }
}
