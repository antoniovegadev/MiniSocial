//
//  Friend+CoreDataProperties.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/31/21.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var friendOrigin: User?

}

extension Friend : Identifiable {

}
