//
//  AppRootContainer.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/26/24.
//

import Foundation

class AppRootContainer: DependencyContainer {
    static let shared: DependencyContainer = AppRootContainer()
    
    var attachedContainers: [any DependencyContainer] = []
    var factories: [ObjectIdentifier : () -> Any] = [:]
    
    private init() {
        //MARK: ViewModels
        self.register(forKey: ListPageViewModel.self){
            ListPageViewModel()
        }
        
        //MARK: Repository
        self.register(forKey: ListPageRepository.self){
            ListPageRepositoryImpl()
        }
        
        self.register(forKey: HomePageRepository.self) {
            HomePageRepositoryImpl()
        }
        
        //MARK: LocalData
        self.register(forKey: UserDefaultsData.self) {
            UserDefaultsDataImpl()
        }
        
        //MARK: RemoteData/Service
        self.register(forKey: ServiceAsync.self) {
            AsyncAwaitService()
        }
        
        self.register(forKey: CombineService.self) {
            CombineServiceImpl()
        }
    }
}
