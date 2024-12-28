//
//  ShimmerView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/28/24.
//

import SwiftUI

extension View {
    func shimmer(active: Bool = true) -> some View {
        self.overlay(
            ShimmerView()
                .opacity(active ? 1 : 0)
        )
    }
}

struct ShimmerView: View {
    @State private var startPoint: UnitPoint = .leading
    @State private var endPoint: UnitPoint = .trailing

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.1), Color.gray.opacity(0.3)]),
                       startPoint: startPoint,
                       endPoint: endPoint)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    self.startPoint = .trailing
                    self.endPoint = .leading
                }
            }
            .mask(Rectangle().cornerRadius(8))
    }
}
