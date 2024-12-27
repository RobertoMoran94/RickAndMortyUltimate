//
//  ViewStateData.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/16/24.
//
import Foundation
import SwiftUICore

enum ViewStateData<T> {
    case loading
    case loaded(T)
    case error
}

enum StaticValues {
    static let placeHolderPath = "rick-and-morty-place-holder-v1"
    static let placeHolderErrorPath = "place-holder-error-image"
}

extension Image {
    static let placeHolder = Image(StaticValues.placeHolderPath)
    static let placeHolderError = Image(StaticValues.placeHolderErrorPath)
    
}
