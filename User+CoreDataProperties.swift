//
//  User+CoreDataProperties.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/30/21.
//
//

import Foundation
import CoreData
import SwiftUI

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var about: String
    @NSManaged public var address: String
    @NSManaged public var age: Int16
    @NSManaged public var company: String
    @NSManaged public var email: String
    @NSManaged public var id: String
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String
    @NSManaged public var registered: Date
    @NSManaged public var friends: NSSet?
    
    public var friendsList: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted {
            $0.name < $1.name
        }
    }
    
    public var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: registered)
    }

    var statusImageFixed: some View {
        Image(systemName: isActive ? "largecircle.fill.circle" : "moon.circle.fill")
            .foregroundColor(isActive ? .green : .purple)
    }

    var statusImageDynamic: some View {
        Image(systemName: isActive ? "largecircle.fill.circle" : "moon.circle.fill")
            .resizable()
            .foregroundColor(isActive ? .green : .purple)
            .background(Circle().fill(Color.black))
    }
}

extension User : Identifiable {

}
