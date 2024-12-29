//
//  ProfileDescriptionView.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//
import SwiftUI

struct ProfileDescriptionView: View {
    let name: String
    let statusColor: Color
    var fontColor: Color = .white
    let specie: String
    let originName: String
    
    var body: some View {
        VStack(alignment: .leading,  spacing: 10){
            Text(name)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(fontColor)
                .padding(.top, 4)
            
            
            HStack(alignment: .center, spacing: 6) {
                Circle()
                    .frame(width: 12, height: 12, alignment: .center)
                    .foregroundStyle(statusColor)
                
                Text(specie)
                    .font(.caption)
                    .foregroundStyle(fontColor)
                    .fontWeight(.medium)
            }
            
            Text(originName)
                .font(.caption)
                .foregroundStyle(fontColor)
                .fontWeight(.medium)
                .fixedSize(horizontal: false, vertical: true)
                .frame(alignment: .center)
            
            Spacer()
        }
    }
}
