//
//  Inject.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/26/24.
//

import Foundation

@MainActor
@propertyWrapper
public struct Inject<T> {
    private var value: T?
    
    public var wrappedValue: T {
        value!
    }
    
    public init() {
        self.value = InjectRoot.dependencyContainer.resolve()
    }
}

@MainActor
public enum InjectRoot {
    static let dependencyContainer: DependencyContainer = DependencyContainerImpl()
    
    final class DependencyContainerImpl: DependencyContainer {
        var attachedContainers: [DependencyContainer] = []
        var factories: [ObjectIdentifier: () -> Any] = [:]
    }
    
    public static func attach(rootContainer: DependencyContainer) {
        InjectRoot.dependencyContainer.attach(container: rootContainer)
    }
}

