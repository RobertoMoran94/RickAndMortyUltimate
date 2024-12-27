//
//  DependencyContainer.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/26/24.
//
import Foundation

@MainActor
public protocol DependencyContainer: AnyObject {
    var attachedContainers: [DependencyContainer] { get set }
    var factories: [ObjectIdentifier: () -> Any] { get set }
    
    func resolve<T>() -> T?
    func attach(container: DependencyContainer)
    func detach(container: DependencyContainer)
    func register<T>(forKey key: T.Type, factory: @escaping () -> T)
}

extension DependencyContainer {
    func resolve<T>() -> T? {
        if let dependency = factories[ObjectIdentifier(T.self)]?() as? T {
            return dependency
        }
        
        for container in attachedContainers {
            if let dependency: T = container.resolve() {
                return dependency
            }
        }
        return nil
    }
    
    func register<T>(forKey key: T.Type, factory: @escaping () -> T) {
        factories[ObjectIdentifier(key)] = factory
    }
    
    func attach(container: DependencyContainer) {
        attachedContainers.append(container)
    }
    
    func detach(container: DependencyContainer) {
        attachedContainers.removeAll { $0 as AnyObject === container as AnyObject }
    }
}
