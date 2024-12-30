//
//  FavoriteCharacter+CoreDataProperties.swift
//  RickAndMorty_SwiftUI_Ultimate
//
//  Created by Roberto Moran on 12/29/24.
//
//

import Foundation
import CoreData


extension FavoriteCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCharacter> {
        return NSFetchRequest<FavoriteCharacter>(entityName: "FavoriteCharacter")
    }

    @NSManaged public var gender: String?
    @NSManaged public var id: String?
    @NSManaged public var locationName: String?
    @NSManaged public var name: String?
    @NSManaged public var originName: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?

}

extension FavoriteCharacter : Identifiable {

}
