//
//  User+CoreDataClass.swift
//  MiniSocial
//
//  Created by Antonio Vega on 5/30/21.
//
//

import Foundation
import CoreData

public class User: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
    enum DecoderConfiguationError: Error {
        case missingObjectContext
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext!] as? NSManagedObjectContext else {
            throw DecoderConfiguationError.missingObjectContext
        }
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(Date.self, forKey: .registered)
        
        let friendArray = try container.decode([Friend].self, forKey: .friends)
        self.friends = NSSet(array: friendArray)
    }
}
